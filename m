From: tony@atomide.com (Tony Lindgren)
Date: Fri, 16 Dec 2011 11:46:21 -0800
Subject: [PATCH] ARM: OMAP AM3517/3505: fix crash on boot due to
 incorrect voltagedomain data
In-Reply-To: <alpine.DEB.2.00.1112160100520.12660@utopia.booyaka.com>
References: <alpine.DEB.2.00.1112160100520.12660@utopia.booyaka.com>
Message-ID: <20111216194620.GE32251@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [111215 23:30]:
> 
> AM3517/3505 chips don't have voltage controller and voltage processor
> IP blocks.  Trying to use OMAP34xx/36xx voltage domain data on these
> chips causes a crash during boot:
> 
>   omap_vc_init_channel: PMIC info requried to configure vc forvdd_core not populated.Hence cannot initialize vc
>   Unable to handle kernel NULL pointer dereference at virtual address 00000025
>   pgd = c0004000
>   [00000025] *pgd=00000000
>   Internal error: Oops: 5 [#1] SMP
>   Modules linked in:
>   CPU: 0    Tainted: G        W     (3.2.0-rc5-00006-g402ecf4 #304)
>   PC is at omap_vp_init+0x5c/0x14c
>   LR is at omap_vp_init+0x54/0x14c
> 
> Fix this by using very minimal voltage domain definitions for AM3517/3505.

Thanks adding this into fixes-non-critical-part2.

Regards,

Tony
