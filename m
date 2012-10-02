From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 2 Oct 2012 12:48:57 +0000
Subject: How many cores does the ARM branch support?
In-Reply-To: <20121002043106.GD21233@work1>
References: <20121002043106.GD21233@work1>
Message-ID: <201210021248.58172.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 02 October 2012, Michelle Konzack wrote:
> I have gotten a new gadget which run only with 700MHz but has  32 cores.
> Support 16 GE Interfaces a 50 Gbit universal interface and 4 PCIe ports,
> SATA HDD and much more...
> 
> ...and yes, this ARM microcontroller is a telecommunications controller.
> 
> However, I have the Evaluation  Kit  and  a  PCIe  graphiccard  and  now
> installed Debian ARMEL.  Unfortunately I get only 2 cores working...
> 
> What must I do to get the other 30 cores?

You have to be a little more specific with the configuration. The mainline
kernel supports no hardware that have more than 4 cores at the moment, so
whatever kernel you are running already has to have some out of tree patches
on it. The system you describe sounds interesting enough to make everyone
want to have another look, but there is no point without looking at those
patches first. Could you upload them to a public git tree?

I suspect that the system you have actually has 16 dual-core systems on
a chip (or on a board), so you could run up to 16 separate instances of
Linux on it, but not a single instance that sees all the cores.

	Arnd
