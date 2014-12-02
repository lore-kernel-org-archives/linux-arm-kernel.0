From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 02 Dec 2014 10:41:57 +0100
Subject: [PATCH v3 05/11] memory: add Atmel EBI (External Bus Interface)
 driver
In-Reply-To: <1724175.Jqk8gQW3pz@ws-stein>
References: <1417429647-3419-1-git-send-email-boris.brezillon@free-electrons.com>
 <2417519.MDE3mu6n7n@wuerfel> <1724175.Jqk8gQW3pz@ws-stein>
Message-ID: <3316464.yrAZ5QMKbg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 02 December 2014 10:18:45 Alexander Stein wrote:
> On Monday 01 December 2014 17:17:30, Arnd Bergmann wrote:
> > On Monday 01 December 2014 11:50:06 Boris Brezillon wrote:
> > > 
> > > I don't have a strong opinion regarding where this driver should
> > > live (I even considered putting it in drivers/bus) :-).
> > > But note that there are other "external memory interface" drivers
> > > in drivers/memory too: TI AEMIF and Marvell DEVBUS  ;-).
> > > 
> > > Does anyone else think this driver should go in drivers/bus ?
> > > 
> > 
> > I think drivers/memory is better.
> 
> I don't mind if it's drivers/bus or drivers/memory. But I'm 
> wondering: When is a driver a bus driver when it is a memory
> driver? See imx-weim and atmel-ebi. Apparently both add support
> for devices attached on a bus which can be accessed through memory
> addresses.

I think drivers/memory should be used for external buses with an
SRAM or DRAM interface that need to configure the timings.

drivers/bus is more a collection for random other buses, usually
internal to a chip, but it's less well-defined.

	Arnd
