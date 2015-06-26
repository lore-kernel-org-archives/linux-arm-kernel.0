From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 26 Jun 2015 16:57:25 +0200
Subject: Support CONFIG_CMDLINE for arm64?
In-Reply-To: <CAErSpo63T1qKyM1N0W=t75ooCURTZJA7X=yG2-SK1vc=i-85bw@mail.gmail.com>
References: <CAErSpo4=11L8QPdeJRFrxR_E7sL+sg2T51TN8KcjmPQoo2Oy=g@mail.gmail.com>
 <20150626131109.GE3078@e104818-lin.cambridge.arm.com>
 <CAErSpo63T1qKyM1N0W=t75ooCURTZJA7X=yG2-SK1vc=i-85bw@mail.gmail.com>
Message-ID: <4056280.9XjjrSUh4E@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 26. Juni 2015, 09:10:37 schrieb Bjorn Helgaas:
> On Fri, Jun 26, 2015 at 8:11 AM, Catalin Marinas
> 
> <catalin.marinas@arm.com> wrote:
> > On Fri, Jun 26, 2015 at 10:15:47AM +0200, Heiko St?bner wrote:
> >> Am Donnerstag, 25. Juni 2015, 17:02:41 schrieb Bjorn Helgaas:
> >> > arch/arm64/Kconfig mentions CONFIG_CMDLINE, but I don't see any actual
> >> > support for it.  Would you be interested in support for it?  Or would
> >> > you rather remove it from Kconfig?
> >> 
> >> just stumbled over your mail by chance.
> >> 
> >> CONFIG_CMDLINE is for example included in drivers/of/fdt.c, so will be
> >> handled correctly for devicetree-based arm64 platforms - and I'm
> >> actually using it on my rk3368 board :-) .
> > 
> > Indeed. The early_init_dt_scan_chosen() takes it into account.
> 
> Excellent, now I just have to figure out why it's not working for me

try with CONFIG_CMDLINE_FORCE? Without it CONFIG_CMDLINE is only used when the 
dts itself does not contain a bootargs property.
