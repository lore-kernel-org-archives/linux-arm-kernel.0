From: tthayer.linux@gmail.com (Thor Thayer)
Date: Fri, 9 May 2014 15:04:47 -0500
Subject: [PATCHv3 3/3] edac: altera: Add EDAC support for Altera SDRAM
In-Reply-To: <536C08B6.2080309@gmail.com>
References: <1399330337-16748-1-git-send-email-tthayer@altera.com>
 <1399330337-16748-4-git-send-email-tthayer@altera.com>
 <536C08B6.2080309@gmail.com>
Message-ID: <CAF03EBdYhGvpNtw+vzRpxyMSxPQ=rM9Fy8rexg-BKFRmTg4o6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 8, 2014 at 5:44 PM, Dinh Nguyen <dinh.linux@gmail.com> wrote:
>
> On 5/5/14 5:52 PM, tthayer at altera.com wrote:
>> From: Thor Thayer <tthayer@altera.com>
>>
>> ---
>> v2: Use the SDRAM controller registers to calculate memory size
>>     instead of the Device Tree. Update To & Cc list. Add maintainer
>>     information.

<snip>

>> +
>> +err2er altr_sdram_edac_driver = {
>> +     .probe = altr_sdram_probe,
>> +     .remove = altr_sdram_remove,
>> +     .driver = {
>> +             .name = "altr_sdram_edac",
>> +             .of_match_table = of_match_ptr(altr_sdram_ctrl_of_match),
> I don't think you need of_match_ptr here for this platform as SOCFPGA is
> only a DT platform. All that of_match_ptr() does for a CONFIG_OF platform
> is just return the pointer.
>
> Dinh

Thanks Dinh. I'll remove it in my next submission.

>> +     },
>> +};
>> +
>> +module_platform_driver(altr_sdram_edac_driver);
>> +
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_AUTHOR("Altera Corporation");
>> +MODULE_DESCRIPTION("EDAC Driver for Altera SDRAM Controller");
>
