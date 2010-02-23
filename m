From: gadiyar@ti.com (Gadiyar, Anand)
Date: Tue, 23 Feb 2010 20:50:55 +0530
Subject: [PATCH 10/11] omap: musb: get rid of dyn_fifo
In-Reply-To: <f3642e6b1002230709r4dcd09bv9c495875bbd873c7@mail.gmail.com>
References: <20100219232648.10559.380.stgit@baageli.muru.com>
	<20100219233036.10559.29778.stgit@baageli.muru.com>
	<4B83EC7C.6020406@corscience.de>
	<f3642e6b1002230709r4dcd09bv9c495875bbd873c7@mail.gmail.com>
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0321A20527@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > I think this patch breaks musb_hdrc.
> >
> > In musb_core_init is musb->config->dyn_fifo checked but is never set.
> >
> > So I get the following dmesg output:
> >
> > musb_hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, bulk combine, bulk split,
> > HB-ISO Rx, HB-ISO Tx, SoftConn)
> > musb_hdrc: MHDRC RTL version 1.400
> > musb_core_init 1405: reconfigure software for Dynamic FIFOs
> > musb_hdrc musb_hdrc: musb_init_controller failed with status -19
> >
> > Thomas
> 
> I think I have the same problem.
> There are other problems right now (I'm trying several different branch/defconfig
> combinations) so I can't be 100% sure.
> 

Ajay reported earlier today [1] that there is a dependency patch [2]
that needs to be taken in. Looks like it was missed when the MUSB
patchset was added to linux-omap for extra testing.

- Anand

[1] http://marc.info/?l=linux-omap&m=126691578831301&w=2
[2] http://marc.info/?l=linux-omap&m=126088393130177&w=2
