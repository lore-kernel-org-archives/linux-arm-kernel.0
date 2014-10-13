From: viric@viric.name (=?iso-8859-1?Q?Llu=EDs?= Batlle i Rossell)
Date: Mon, 13 Oct 2014 14:32:17 +0200
Subject: Regarding tx-nocache-copy in the Sheevaplug
In-Reply-To: <1413203171.9362.81.camel@edumazet-glaptop2.roam.corp.google.com>
References: <20141013105246.GD1972@vicerveza.homeunix.net>
 <1413203171.9362.81.camel@edumazet-glaptop2.roam.corp.google.com>
Message-ID: <20141013123217.GF1972@vicerveza.homeunix.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 13, 2014 at 05:26:11AM -0700, Eric Dumazet wrote:
> On Mon, 2014-10-13 at 12:52 +0200, Llu?s Batlle i Rossell wrote:
> > Hello,
> > 
> > on the 7th of January 2014 ths patch was applied:
> > https://lkml.org/lkml/2014/1/7/307
> > 
> > [PATCH v2] net: Do not enable tx-nocache-copy by default
> >         
> > In the Sheevaplug (ARM Feroceon 88FR131 from Marvell) this made packets to be
> > sent corrupted. I think this machine has something special about the cache.
> > 
> > Enabling back this tx-nocache-copy (as it used to be before the patch) the
> > transfers work fine again. I think that most people, encountering this problem,
> > completely disable the tx offload instead of enabling back this setting.
> > 
> > Is this an ARM kernel problem regarding this platform?
> 
> Which NIC and driver is this exactly ?

According to dmesg in 3.10.1:
[    7.858872] mv643xx_eth: MV-643xx 10/100/1000 ethernet driver version 1.4
[    7.866001] mv643xx_eth_port mv643xx_eth_port.0 eth0: port 0 with MAC address 00:50:43:01:d1:bb

Regards,
Llu?s.
