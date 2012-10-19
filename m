From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 Oct 2012 09:03:37 +0000
Subject: [PATCH v2 1/5] ARM: bcm476x: Add platform infrastructure
In-Reply-To: <20121018154731.GA9344@glitch>
References: <20121014221450.866288977@gmail.com>
 <201210181348.02110.arnd@arndb.de> <20121018154731.GA9344@glitch>
Message-ID: <201210190903.38142.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 October 2012, Domenico Andreoli wrote:
> On Thu, Oct 18, 2012 at 01:48:01PM +0000, Arnd Bergmann wrote:
> > On Sunday 14 October 2012, Domenico Andreoli wrote:
> +
> +Boards with the BCM4760 SoC shall have the following properties:
> +
> +Required root node property:
> +
> +compatible = "brcm,bcm4760";
> +
> +
> +Boards with the BCM4761 SoC shall have the following properties:
> +
> +Required root node property:
> +
> +compatible = "brcm,bcm4760", "brcm,bcm4761";
> 
> and the dt_mach in the board file is left only with "brcm,bcm4760" until
> required otherwise. The same applies to drivers.

Right.

> Does the order matter? 

Yes, you have to have the most specific one first, and the most generic
one last, as documented in Documentation/devicetree/booting-without-of.txt.

If one chip has a functionality that the other one doesn't but is otherwise
completely compatible, then the less capable one should be put last.

For the root node, you might actually want to keep both "compatible" strings
separate as you have in the version you posted, at least if the chips are
not completely backwards compatible. For the other devices inside of the
soc, just use one.

> > For the patches that go into different directories like the clk
> > and the clocksource drivers, please Cc the respective subsystem
> > maintainers and ask them for an Ack. It certainly makes sense
> > for a new platform port to get merged through the arm-soc tree,
> > but any future improvements should normally just go through the
> > subsystem trees.
> 
> I'd prefer patches but only because I've not any public git repository. If
> the git pull is much more preferred, I surely can manage it.

Ok, no problem. In the long run, it can be useful for you to set up 
your own git tree, for for now, we can manage with patches just fine.

	Arnd
