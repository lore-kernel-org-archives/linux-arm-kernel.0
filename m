From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Mar 2017 17:18:39 +0000
Subject: No output on console despite ignore_loglevel earlyprintk
In-Reply-To: <0e7d14d5-d087-cba3-1792-fb0abf1142ef@sigmadesigns.com>
References: <6d16a384-1a4c-bf27-fd81-ea3caf3de6b0@sigmadesigns.com>
 <6cc48f5c-b028-2bb7-c09b-92c36554fe07@suse.de>
 <0e7d14d5-d087-cba3-1792-fb0abf1142ef@sigmadesigns.com>
Message-ID: <20170303171839.GP21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 03, 2017 at 06:07:39PM +0100, Marc Gonzalez wrote:
> On 03/03/2017 17:59, Andreas F?rber wrote:
> >> I suppose this is related to my DT description?
> >>
> >> 	chosen {
> >> 		stdout-path = "serial:115200n8";
> >> 	};
> >>
> >> Isn't stdout-path = "serial:115200n8" supposed to be equivalent to
> >> console=ttyS0,115200 ?
> > 
> > First of all, that should probably be serial0, and it needs to be
> > defined as an alias. In my case that's a given.
> 
> My DT root node contains
> 
> 	aliases {
> 		serial = &uart;
> 		eth0 = &eth0;
> 	};
> 
> Should I be using serial0 everywhere?
> (I thought I could call it "foo", if I wanted.)

Correct, stdout-path contains the node name - please see
Documentation/devicetree/bindings/chosen.txt for the definitive
information.

Setting the early console has no effect on the eventual system
console that the kernel chooses.  See these files:

drivers/of/fdt.c
drivers/tty/serial/earlycon.c

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
