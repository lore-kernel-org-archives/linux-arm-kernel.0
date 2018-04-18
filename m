From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 18 Apr 2018 16:20:03 +0200
Subject: [PATCH 0/2] Allow xhci-plat using a second clock
In-Reply-To: <20180214161620.4401-1-gregory.clement@bootlin.com> (Gregory
 CLEMENT's message of "Wed, 14 Feb 2018 17:16:18 +0100")
References: <20180214161620.4401-1-gregory.clement@bootlin.com>
Message-ID: <87r2ncfvfw.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mathias,
 
 On mer., f?vr. 14 2018, Gregory CLEMENT <gregory.clement@bootlin.com> wrote:

> Hello,
>
> The purpose of this series is to allow xhci-plat using a second
> clock. It is needed on the Armada 7K/8K but could be used by other
> SoCs.
>
> The first patch is just a fix found while I was working on this
> feature.

I've just realized that this series sent 2 months ago was not merged in
v4.17. The issue is that now the USB support on the Armada 7K/8K is
broken, because the clock support part was already merged.

You already had a look on this series one month ago. The issue you had
was about getting an approval for the extension of the binding [1]. I
pinged Rob about it [2] one month ago but we didn't get any
feedback. However, Rob already approved the similar changes I introduced
in an other for mv_xor_v2: [3].

So would it be possible to apply this series on v4.17-rc ?

Thanks,

Gregory

[1]:
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-February/562739.html

[2]:
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-March/566076.html

[3]:
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-March/564594.html




>
> Thanks,
>
> Gregory
>
>
> Gregory CLEMENT (2):
>   usb: host: xhci-plat: Remove useless test before clk_disable_unprepare
>   usb: host: xhci-plat: Fix clock resource by adding a register clock
>
>  Documentation/devicetree/bindings/usb/usb-xhci.txt |  5 ++-
>  drivers/usb/host/xhci-plat.c                       | 39 ++++++++++++++++------
>  drivers/usb/host/xhci.h                            |  3 +-
>  3 files changed, 35 insertions(+), 12 deletions(-)
>
> -- 
> 2.15.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
