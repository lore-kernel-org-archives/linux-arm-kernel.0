From: agnel.joel@gmail.com (Joel A Fernandes)
Date: Mon, 29 Oct 2012 19:33:06 -0500
Subject: [PATCH] ARM: OMAP2+: AM33XX: clock data: fix mcasp entries
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C33EAB8596@DBDE01.ent.ti.com>
References: <1349879449-22657-1-git-send-email-mporter@ti.com>
 <1BAFE6F6C881BF42822005164F1491C33EAB8596@DBDE01.ent.ti.com>
Message-ID: <CAD=GYpY5-X3BJZEQ1aD4+mKxFNvb4Ug67FtXdLbNwKxWoFvA3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guraraja,

I am interested in this thread. I've been trying Gururaja's patches for
audio as well.

I rebased  Guraja's patches on top of Matt's EDMA patches which were
applied to the beaglebone 3.7 kernel repo. With some fixes to make it
compile with CONFIG_DUMMY_REGULATOR enabled, Currently it breaks at
set_dai_fmt in davinci-mcasp.c when an audio file is played.

Could you try my tree on EVM?  dts changes may be required to use mcasp1 on
EVM,
https://github.com/joelagnel/linux-kernel/commits/3.7

v3.7-rc2-fixes to v3.7-rc2-audio commits are Gururaja's patches which I
applied, and after that are my commits to enable config , add dt data and
some fixes.

Thanks,
Joel

On Mon, Oct 29, 2012 at 10:45 AM, Hebbar, Gururaja
<gururaja.hebbar@ti.com>wrote:

> Matt,
>
> On Wed, Oct 10, 2012 at 20:00:49, Porter, Matt wrote:
> > 6ea74cb ARM: OMAP2+: hwmod: get rid of all omap_clk_get_by_name usage
> > exposes a bug in the AM33XX clock data for mcasp. After moving to
> > clk_get() usage, the _init() of all registered hwmods fails on mcasp0
> > due to incorrect clock data causing clk_get() to fail. This causes all
> > successive hwmods to fail to _init() leaving them in a bad state.
> >
> > This patch updates the mcasp clock entries so clk_get() will succeed.
> > It is tested on BeagleBone and is needed for 3.7-rc1 to fix AM33xx
> > boot.
>
>
> I want to test Audio on AM335x Evm with your EDMA patches. I have few
> patches for AM335x.
> Can you share the link to the repo & branch on which I need to rebase?
> The patches are related to mcasp dt node, mcasp pinmux in dt, etc...
>
> >
> ..snip..
> ..snip..
> >
>
>
> Thanks & Regards,
> Gururaja
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121029/dcae992c/attachment-0001.html>
