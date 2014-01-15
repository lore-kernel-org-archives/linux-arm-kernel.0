From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 14 Jan 2014 19:16:32 -0800
Subject: [PATCHv13 00/40] ARM: TI SoC clock DT conversion
In-Reply-To: <20140115020421.GA24195@saruman.home>
References: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
 <52CF12FB.6000602@ti.com>
 <20140109231513.GA11648@saruman.home> <52CFC2F1.706@ti.com>
 <20140110161352.GG6665@saruman.home> <52D02037.3090705@ti.com>
 <20140110185110.GM31323@atomide.com> <52D53084.1070105@ti.com>
 <20140114203613.GA604@saruman.home> <20140115020421.GA24195@saruman.home>
Message-ID: <20140115031632.4167.2698@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Felipe Balbi (2014-01-14 18:04:21)
> Hi,
> 
> On Tue, Jan 14, 2014 at 02:36:13PM -0600, Felipe Balbi wrote:
> > > Felipe, care to run your randconfig magic for this?
> > 
> > This branch builds just fine so far, I still have omap5 multiplaform and
> > uniplatform builds, but since that was working before i'm assuming it
> > won't break.
> 
> No build failures in any of my 18 seeds (5 randconfigs of each), I'd
> attach logs, but it's a 2.8MiB tarball, if anyone cares enough, I can
> send it.
> 
> FWIW:
> 
> Acked-by: Felipe Balbi <balbi@ti.com>

Felipe,

That's great to hear. Thanks for testing.

Tero & Tony,

These 40 patches apply very cleanly on top of clk-next with 2
exceptions:

1) I did not apply "[PATCH 30/42] ARM: dts: AM35xx: use DT clock data"
because I do not have arch/arm/boot/dts/am3517.dtsi in clk-next (based
on 3.13-rc1).

2) Minor merge conflict in arch/arm/boot/dts/omap3.dtsi which I think I
resolved correctly but would like verification.

I'd prefer to simply merge these patches into clk-next, which is the
most straightforward route. Any ideas on how to handle the missing
AM35xx dtsi data? It can always go as a separate fix after this stuff
gets merged which, ironically, is how that file was created in the first
place.

Regards,
Mike

> 
> cheers
> 
> -- 
> balbi
