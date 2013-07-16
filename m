From: josh.wu@atmel.com (Josh Wu)
Date: Tue, 16 Jul 2013 15:54:54 +0800
Subject: [PATCH 1/5] iio: at91: use adc_clk_khz to make the calculation
 not easy to large than u32.
In-Reply-To: <20130715125213.GB2962@lukather>
References: <1373789069-11604-1-git-send-email-josh.wu@atmel.com>
 <1373789069-11604-2-git-send-email-josh.wu@atmel.com>
 <20130715125213.GB2962@lukather>
Message-ID: <51E4FC4E.2010203@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Maxime

On 7/15/2013 8:52 PM, Maxime Ripard wrote:
> Hi Josh,
>
> On Sun, Jul 14, 2013 at 04:04:25PM +0800, Josh Wu wrote:
>> for example, if adc_clk is 20Mhz and start-up time set as larger than 215us.
>> then the calculation "st->startup_time * adc_clk_khz" will out of u32.
>>
>> In this patch, it will use khz unit for adc_clk, that avoids above problem.
>>
>> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> Maybe we can have a slightly better commit log here, like:
>
> ------8<-----------
> iio: at91: Fix adc_clk overflow
>
> The adc_clk variable is currently defined using a 32-bits unsigned
> integer, which will overflow under some very valid range of operations.
>
> Such overflow will occur if, for example, the parent clock is set to a
> 20MHz frequency and the ADC startup time is larger than 215ns.
>
> To fix this, introduce an intermediate variable holding the clock rate
> in kHz.
>
> --------8<---------------
>
> Or something like that.
>
> For the patch itself, I'm happy about it. You can add my Acked-by.

Thank you. Your commit log is better. I will fix the commit log base on 
your commit in next version.

>
> Thanks!
> Maxime
>

Best Regards,
Josh Wu
