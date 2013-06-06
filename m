From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 6 Jun 2013 15:55:43 +0530
Subject: [PATCH v2 5/5] ARM: davinci: serial: platform code cleanup
In-Reply-To: <51AF2400.3020906@ti.com>
References: <1369729686-6595-1-git-send-email-prakash.pm@ti.com>
 <1369729686-6595-6-git-send-email-prakash.pm@ti.com>
 <51AF2400.3020906@ti.com>
Message-ID: <51B063A7.8020907@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/5/2013 5:11 PM, Sekhar Nori wrote:
> 
> On 5/28/2013 1:58 PM, Manjunathappa, Prakash wrote:
>> 1) "struct davinci_uart_config" is introduced to specify
>>    UART ports brought out or enabled on the board. But
>>    none of the boards use them for that purpose, so clean
>>    it up.
>> 2) Have pointer to platform device as a argument for
>>    davinci_serial_init(), no need of serial_dev in
>>    struct soc_info now.
>> 3) No need of davinci_serial_setup_clk(), not called from
>>    multiple places, hence reduce function call overhead.
>>
>> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
>> Suggested-by: Sekhar Nori <nsekhar@ti.com>
> 
> We generally clean up code before undertaking modifications. Is there a
> reason why this cannot be done first-up?

Never mind this question. I figured it out myself. You need to have the
serial clock setup removed from DT before you can do any reasonable
clean-up and that happens only with 4/5.

Thanks,
Sekhar
