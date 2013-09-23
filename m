From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 23 Sep 2013 21:19:17 +0300
Subject: [PATCH 1/3] Add smp support for Allwinner A20(sunxi 7i).
In-Reply-To: <523FB773.4050408@roeck-us.net>
References: <1379768716-11672-1-git-send-email-cinifr@gmail.com>
 <1379768716-11672-2-git-send-email-cinifr@gmail.com>
 <20130921140059.GA2779@lukather> <523FB773.4050408@roeck-us.net>
Message-ID: <20130923181917.GS2779@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guenter,

On Sun, Sep 22, 2013 at 08:37:23PM -0700, Guenter Roeck wrote:
> On 09/21/2013 07:00 AM, Maxime Ripard wrote:
> 
> [ ... ]
> 
> >>+	/* assert cpu core reset */
> >>+	writel(0, sunxi7i_cc_base + CPUX_RESET_CTL(cpu));
> >>+	/* L1RSTDISABLE hold low */
> >>+	pwr_reg = readl(sunxi7i_cc_base + AW_CPUCFG_GENCTL);
> >>+	pwr_reg &= ~(1<<cpu);
> >>+	writel(pwr_reg, sunxi7i_cc_base + AW_CPUCFG_GENCTL);
> >>+	/* DBGPWRDUP hold low */
> >>+	pwr_reg = readl(sunxi7i_cc_base + AW_CPUCFG_DBGCTL1);
> >>+	pwr_reg &= ~(1<<cpu);
> >
> >Use BIT(cpu) here. And you should run scripts/checkpatch.pl on your
> >patches before sending them.
> >
> 
> For the record:
> 
> $ scripts/checkpatch.pl --strict allwinner.patch
> total: 0 errors, 0 warnings, 0 checks, 527 lines checked
> 
> allwinner.patch has no obvious style problems and is ready for submission.
> 
> This is on top of "v3.12-rc1-336-gd8524ae".
> 
> checkpatch.pl does not complain as long as the number of spaces before
> and after an operator is the same. There is a patch pending to change
> this with the --strict option, but it will still not complain in 'normal'
> operation.

Hmmm, ok. Somehow, I was convinced that it was triggering a warning.
Thanks for the heads up :)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130923/c7dcb961/attachment.sig>
