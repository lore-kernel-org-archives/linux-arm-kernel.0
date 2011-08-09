From: rvaswani@codeaurora.org (Rohit Vaswani)
Date: Mon, 08 Aug 2011 18:45:16 -0700
Subject: [PATCH] GPIOLIB: add generic gpio_set_pull API
In-Reply-To: <CAH9JG2V-66Wn7nwJz6tOkESoQAUJzAg-47YeMY0vzwu6T9O=Rg@mail.gmail.com>
References: <1312780773-23142-1-git-send-email-Baohua.Song@csr.com>
	<20110808081552.GI32513@linux-sh.org>
	<CACxGe6ssT4=kxApaKhv+=7nDcEFVW+oyByFQ_hzcfyZ4gw2C3g@mail.gmail.com>
	<CAH9JG2V-66Wn7nwJz6tOkESoQAUJzAg-47YeMY0vzwu6T9O=Rg@mail.gmail.com>
Message-ID: <4E40912C.5040801@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/8/2011 3:57 PM, Kyungmin Park wrote:
> On Tue, Aug 9, 2011 at 3:24 AM, Grant Likely<grant.likely@secretlab.ca>  wrote:
>> On Mon, Aug 8, 2011 at 2:15 AM, Paul Mundt<lethal@linux-sh.org>  wrote:
>>> On Sun, Aug 07, 2011 at 10:19:33PM -0700, Barry Song wrote:
>>>> Now there are many different implementations for GPIO pull configuration, for
>>>> example:
>>>> s3c_gpio_setpull()
>>>> tegra_pinmux_set_pullupdown()
>>>> chipcHw_setPinPullup()
>>>> gpio_pullup()
>>>> s3c2410_gpio_pullup()
>>>>
>>>> This patch adds a new generic gpio_set_pull API so that all SoCs can have unified
>>>> codes.
>>>>
>>>> Signed-off-by: Barry Song<Baohua.Song@csr.com>
>>> For arch/arm/mach-shmobile we also have gpio_pull_up() for board-g4evm.c
>>> and gpio_pull_down() for board-mackerel.c. Both of these would benefit
>>> from this sort of an API addition.
>> I think I'm okay with this API change.  Linus, what say you?  How does
>> this interact with your plans for pinctrl?
> If gpiolib accept the pullup control. gpiolib is better place to
> control gpio config.
> then remains are the gpio driver strength, and power down mode
> control. powerdown pull-up/down, powerdown in/out at samsung gpios.
If we add this API - the remaining gpio controls like drive strength and 
function select could also be added, which eats into the pinmux domain.
Linus W. had a patch earlier which added an API for a gpio config to be 
specified through gpiolib. " gpio: add a custom configuration mechanism 
to gpiolib" which is sort of an extensible model of this API.

Thanks,
Rohit
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Thanks,
Rohit Vaswani

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
