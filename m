From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Mon, 05 Aug 2013 19:18:40 -0700 (PDT)
Subject: [PATCH v6 3/3] ARM: shmobile: lager: enable nfsroot in DTS
In-Reply-To: <20130806010736.GA20940@verge.net.au>
References: <1375175361-23027-1-git-send-email-horms+renesas@verge.net.au>
 <1375175361-23027-4-git-send-email-horms+renesas@verge.net.au>
 <87bo5h3lb3.wl%kuninori.morimoto.gx@renesas.com>
 <20130801080226.GF15265@verge.net.au>
 <20130806010736.GA20940@verge.net.au>
Message-ID: <87r4e7h88z.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Simon

> > > >  	chosen {
> > > > -		bootargs = "console=ttySC6,115200 ignore_loglevel";
> > > > +		bootargs = "console=ttySC6,115200 ignore_loglevel root=/dev/nfs ip=dhcp nfsroot=,rsize=4096,wsize=4096 rw";
> > > 
(snip)
> The purpose of adding NFS information to bootargs in r8a7790-lager.dts is
> to cause the lager board to use NFS root when booting from using the C
> version of the board code which lives in board-lager.c. This is in contrast
> to the DT reverence version of the board code, which uses DT more heavily,
> does not initialise sh-eth because DT bindings are not available (as far as
> I know) and is not effected by r8a7790-lager.dts.
> 
> Historically this kind of NFS information was added to the command line in
> the defconfig.  However, as part of the long journey to consolidate (reduce
> the number of) shmobile defconfigs it now goes in DT instead.

Thank you.
I don't have any objection to bootargs having NFS information.
My question was only for "rsize/wsize".
Sorry for my confusion English.

> With regards to the "rsize/wsize" settings, I will remove them.
> However, I do see them present in the following files and I believe
> historically they were present in some of the shmobile defconfigs.
> 
> emev2-kzm9d-reference.dts
> emev2-kzm9d.dts
> r8a7740-armadillo800eva-reference.dts
> r8a7740-armadillo800eva.dts

I see.
I don't know why these defconfigs have "rsize/wsize".
But, this information was needed on old kernel version somehow (I forgot when, which version),
and (I guess) there is no such issue now.
We can remove it ?

Best regards
---
Kuninori Morimoto
