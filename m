From: b.brezillon@overkiz.com (boris brezillon)
Date: Mon, 29 Jul 2013 11:25:42 +0200
Subject: [PATCH v2 00/42] ARM: at91: move to common clk framework
In-Reply-To: <CACQ1gAgw-v3z_sWcsk7SqFFW-ERLjS0RS5GTgAdd5Y1tj3Z1FA@mail.gmail.com>
References: <1374068069-13496-1-git-send-email-b.brezillon@overkiz.com>
 <51F28370.6050304@gmail.com> <51F2996B.6000406@overkiz.com>
 <51F2A556.8020109@overkiz.com>
 <CACQ1gAgw-v3z_sWcsk7SqFFW-ERLjS0RS5GTgAdd5Y1tj3Z1FA@mail.gmail.com>
Message-ID: <51F63516.8090000@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/07/2013 10:00, Richard Genoud wrote:
> 2013/7/26 boris brezillon <b.brezillon@overkiz.com>:
>> On 26/07/2013 17:44, boris brezillon wrote:
>> I found 2 bugs:
>> 1) the main frequency ready test in recalc_rate function is wrong
>> 2) the common clk framework uses the first match for dt clk registration
>>     and main clk has this compatible property:
>>     compatible = "atmel,at91rm9200-clk-main", "fixed-clock";
>>     As a result the main clk is always bound to the fixed-clock driver
>>     which set the clock frequency to 0 if 'clock-frequency' property is
>>     missing.
>>
>> These bugs will be fixed in next version.
>> Tell me if you want need thesse patches for testing purpose.
> Hi Boris,
>
> I tested your patch, the clock is not at 0 anymore:
> AT91: PIT: mck rate = 8333333
>
> And it's booting correctly.
> There's a small bug I found in the at91sam9x5 dtsi file (ssc id is 28,
> not 27). (patch attached)
>
> And yes, I could use your patches for some more tests !
>
> Thanks,
>
> Richard.
Hi Richard,

Thanks for the bug report.

You'll find in attachements the pre-v3 series fixing the detected bugs 
(including the ssc clock id bug).

If you need anything else please let me know.

Best Regards,

Boris
-------------- next part --------------
A non-text attachment was scrubbed...
Name: at91-clk-v3.tgz
Type: application/x-compressed-tar
Size: 61170 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130729/5d4fdc8f/attachment-0001.bin>
