From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Thu, 01 Aug 2013 00:46:44 -0700 (PDT)
Subject: [PATCH v6 3/3] ARM: shmobile: lager: enable nfsroot in DTS
In-Reply-To: <1375175361-23027-4-git-send-email-horms+renesas@verge.net.au>
References: <1375175361-23027-1-git-send-email-horms+renesas@verge.net.au>
 <1375175361-23027-4-git-send-email-horms+renesas@verge.net.au>
Message-ID: <87bo5h3lb3.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Simon

> Now that Ether support has been added to the lager board
> it is possible to use nfsroot. This configuration is
> in line with that of other shmobile boards.
> 
> Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(snip)
>  	chosen {
> -		bootargs = "console=ttySC6,115200 ignore_loglevel";
> +		bootargs = "console=ttySC6,115200 ignore_loglevel root=/dev/nfs ip=dhcp nfsroot=,rsize=4096,wsize=4096 rw";

Could you please add why this "rsize/wsize" settings
are needed on bootargs ?
(other shmobile board's dts file doesn't have these)

And, I guess r8a7790-lager.dts/r8a7790.dts doesn't have
"sh-eth" driver DT settings, (or I'm missing ?)
but you added network/nfsroot settings on bootargs.
It is OK for me, but for what ?

Best regards
---
Kuninori Morimoto
