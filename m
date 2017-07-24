From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 24 Jul 2017 10:18:46 +0200
Subject: [PATCH 3/4] arm: sunxi: Add AXP20X_ADC
In-Reply-To: <CAGb2v64tx6M1CJSKr_wgD4LM+-ER+Yqpj-hUftptj41PVhbBBA@mail.gmail.com>
References: <20170721162005.18892-1-maxime.ripard@free-electrons.com>
 <20170721162005.18892-3-maxime.ripard@free-electrons.com>
 <CAGb2v64tx6M1CJSKr_wgD4LM+-ER+Yqpj-hUftptj41PVhbBBA@mail.gmail.com>
Message-ID: <20170724081846.b2rokuwhyuymj3sj@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Jul 22, 2017 at 10:19:08AM +0800, Chen-Yu Tsai wrote:
> On Sat, Jul 22, 2017 at 12:20 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The APX20X_POWER option, that is a dependency of the USB controllers
> > depends on IIO and AXP20X_ADC. Add it so that we can get a working USB
> > back.
> 
> The statement is only half true. AXP20X_POWER can fall back to reading
> the ADC registers directly if AXP20X_ADC is not enabled. Is there a plan
> to remove this feature?

I never really considered this a feature, but some compatibility for
older DTs to be honest :)

> Also, AXP20X_ADC is only really needed if the hardware is AXP20x, and
> not the later ones that don't have voltage/current sensing. I would
> like to change the hard dependency on AXP20X_ADC to the "imply"
> keyword in Kconfig for the AC and battery power supply drivers.

I'm not sure. It's also needed when you want to read the battery
voltage and current, or the AC-IN voltage. And that's a feature found
on all PMICs.

And since the battery and the AC-IN power supplies also have a
dependency on AXP20X_ADC, I guess we can just add a depnds on. In most
configuration, it's going to be enabled anyway.

> That is another discussion though.

Indeed.

> So I think the description should be something like
> 
>     AXP20X_POWER depends on IIO. Even though it does not depend on
>     AXP20X_ADC, it is the new, preferred way of getting power supply
>     readings. The other AXP power supply drivers use it as well.
> 
>     Enable both options.

That works for me.

With that comment, do I have your Acked-By?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170724/bed2243b/attachment.sig>
