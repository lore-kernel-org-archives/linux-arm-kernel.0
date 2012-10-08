From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 8 Oct 2012 22:29:59 +0200
Subject: [PATCH 5/6] ARM: dove: Remove watchdog from DT
In-Reply-To: <201210082010.13928.arnd@arndb.de>
References: <1348531338-16624-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20121008184016.GA30416@jirafa.cyrius.com>
 <20121008195706.GM21046@lunn.ch> <201210082010.13928.arnd@arndb.de>
Message-ID: <20121008202959.GN21046@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd

> > It is great you offered to test. I have a Marvell orion5x reference
> > system, rd88f5182. So i can do a lot of the conversion using
> > that. What i think will cause problems is PCI. There is scary looking
> > PCI code in the -setup.c files. I don't know how easy that will be to
> > convert to DT. However, it looks like most targets don't actually use
> > PCI, so maybe some will be easier to convert than others.
> 
> I can offer some help with the PCI bits. I don't have any orion hardware,
> but if you get stuck, you can find me on IRC or we can talk on the phone
> about how it should be done.

Thanks for the offer.

I know that the Free Electron guys, Thomas or Gregory, will be looking
at PCI for 370/XP soon and Kirkwood and Dove are in scope for that
work, as far as i know. So i will see how that developers, maybe lend
a hand, and see how easy it is to integrate support for Orion5x.

I suspect Orion5x might be a problem though. Its both PCI and PCIe,
where as the others are purely PCIe and orion5x has WA access method,
which all the other Marvell systems don't have. Also, it seems like
some Orion5x boards have the PCI IRQ on GPIO lines where as all the
other SoC have dedicated pins.

      Andrew
