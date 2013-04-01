From: tpiepho@gmail.com (Trent Piepho)
Date: Mon, 1 Apr 2013 16:32:25 -0700
Subject: [PATCH 4/5] spi/mxs: Remove bogus setting of ssp clk rate field
In-Reply-To: <201304020116.04781.marex@denx.de>
References: <1364570381-17605-1-git-send-email-tpiepho@gmail.com>
 <1364570381-17605-4-git-send-email-tpiepho@gmail.com>
 <201304020116.04781.marex@denx.de>
Message-ID: <CA+7tXihhL2ETT+AgvX5KASZOOgi6bucModE88ztY9Q8U1gDbOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 1, 2013 at 4:16 PM, Marek Vasut <marex@denx.de> wrote:
>> The ssp struct has a clock rate field, to provide the actual value, in Hz,
>> of the SSP output clock (the rate of SSP_SCK) after mxs_ssp_set_clk_rate()
>> is called.  It should be read-only, except for mxs_ssp_set_clk_rate().
>>
>> For some reason the spi-mxs driver decides to write to this field on init,
>> and sets it to the value of the SSP input clock (clk_sspN, from the MXS
>> clocking block) in kHz.  It shouldn't be setting the value, and certainly
>> shouldn't be setting it with the wrong clock in the wrong units.
>
> I suspect this patch should also fix drivers/clk/mxs/clk-ssp.c then?

Why do you say that?  I see no problem with clk-ssp.c, as setting the
clk_rate field in the ssp struct to the actual programmed rate makes
sense.  The code in spi-mxs.c just makes no sense.  I suspect it was
added by mistake when porting the driver.
