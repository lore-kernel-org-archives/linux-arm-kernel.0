From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 09 Jul 2012 16:47:32 -0400 (EDT)
Subject: [PATCH 07/15] ARM: dove: use fixed PCI i/o mapping
In-Reply-To: <4FFB2321.30100@gmail.com>
References: <1341600040-30993-1-git-send-email-robherring2@gmail.com>
 <1341600040-30993-8-git-send-email-robherring2@gmail.com>
 <201207091550.55912.arnd@arndb.de> <4FFB2321.30100@gmail.com>
Message-ID: <alpine.LFD.2.02.1207091641030.31100@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 9 Jul 2012, Rob Herring wrote:

> Why use 1M when 64K is enough based on our prior conversations? The more
> we standardize the configuration, the more we can make common. I think
> the majority of the pci setup functions can be consolidated. It's really
> just data differences for the resource setup. I only used 1M alignment
> in case there were some alignment requirements in the h/w and it can't
> handle a starting pci bus address of 0x10000. I think it's just the
> Marvell parts that do this, so if anyone knowledgeable on those parts
> can comment it would help.

The only Marvell board I have which can accommodate a PCI card does 
support 3.3V PCI cards only.  Otherwise this is all PCI Express.  And 
the only PCI cards with I/O space I've seen are 5V PCI cards.

So I'd say: go for the option with the best consolidation outcome.  No 
one is using cards with I/O space on those platforms.


Nicolas
