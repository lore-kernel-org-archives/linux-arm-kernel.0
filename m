From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Sun, 28 Jul 2013 17:20:43 -0700 (PDT)
Subject: [PATCH] ARM: shmobile: BOCK-W: fix SDHI0 PFC settings
In-Reply-To: <51F30C60.5050504@cogentembedded.com>
References: <201307270346.34002.sergei.shtylyov@cogentembedded.com>
 <51F30C60.5050504@cogentembedded.com>
Message-ID: <87bo5mrzcc.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Simon

> > The following message is printed on the BOCK-W kernel bootup:
> 
> > sh-pfc pfc-r8a7778: invalid group "sdhi0" for function "sdhi0"
> 
> > In addition, SD card cannot be detected.  The reason is apparently that commit
> > ca7bb309485e4ec89a9addd47bea (ARM: shmobile: bockw: add SDHI0 support) matched
> > the previous version of commit 564617d2f92473031d035deb273da5 (sh-pfc: r8a7778:
> > add SDHI support).
> 
> > Add the missing pin groups according to the BOCK-W board schematics.
> 
> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> > ---
> > The patch is atop of Simon's 'renesas.git' repo, 'renesas-devel-20130726' tag.
> 
>     It also applies to the current Linus' tree cleanly. Please push it for 3.11.
> 
> WBR, Sergei

Something happen on patch.

Linux/master branch seems have old verion.

---- linux/master : old version --------------------------
commit ca7bb309485e4ec89a9addd47beaa1d079841b7d
Author: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date:   Wed Apr 17 05:17:56 2013 +0000

    ARM: shmobile: bockw: add SDHI0 support
    
    This patch is directly accessing to PUPR4 register which can
    control SDHI0 CD/WP pin pull-up setting.
    It should be replaced in the future.
    
    Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
----------------------------------------------------------

This is the correct/latest version

----- correct version ---------------------------------------------
commit c2ee46ab49ce3bb5a60b36940e70355beb409acf
Author: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date:   Thu Apr 18 20:09:32 2013 -0700

    ARM: shmobile: bockw: add SDHI0 support
    
    This patch is directly accessing to PUPR4 register which can
    control SDHI0 CD/WP pin pull-up setting.
    It should be replaced in the future.
    
    Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
-------------------------------------------------------------------

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Best regards
---
Kuninori Morimoto
