From: philippe.retornaz@gmail.com (=?ISO-8859-1?Q?Philippe_R=E9tornaz?=)
Date: Mon, 02 Jun 2014 19:18:16 +0200
Subject: [PATCH 1/5] ARM: imx: Use PTR_ERR_OR_ZERO in platform-mxc_rnga.c
In-Reply-To: <20140529080321.GF8860@dragon>
References: <1401339434-26085-1-git-send-email-sachin.kamat@linaro.org>
 <20140529080321.GF8860@dragon>
Message-ID: <538CB1D8.5080809@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 29/05/2014 10:03, Shawn Guo a ?crit :
> On Thu, May 29, 2014 at 10:27:10AM +0530, Sachin Kamat wrote:
>> PTR_ERR_OR_ZERO simplifies the code.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org> ---
>> arch/arm/mach-imx/devices/platform-mxc_rnga.c |    6 ++---- 1 file
>> changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-imx/devices/platform-mxc_rnga.c
>> b/arch/arm/mach-imx/devices/platform-mxc_rnga.c index
>> [...]
>
> The existing code looks just fine and actually more readable to me.
> Also, all the files you are patching will eventually be killed by DT
> support.  So let's just leave it there as it is for now.

heh ... well ... not so fast please !
There is a non-negligible amount of work to have a fully functional
imx31 on DT.

Not working:
- USB  (chipidea driver sort of works, but the PHY is a complete mess).
- Camera
- SPI hardware chip select support
- pinmux support is totally absent

Currently, on imx31 we can boot on DT with (and only if the bootloader
does the pinmux for you):
- SDMA
- Watchdog
- SDHC
- Timer
- Uart

And I did not even had a look at the i2c, EMI, LCD and sound support.

So I hope imx31 platform boards can stay until the situation gets better.

Thanks,

Philippe
