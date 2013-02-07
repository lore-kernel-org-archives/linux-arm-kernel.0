From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 Feb 2013 23:33:11 +0000
Subject: Giving special alignment/size constraints to the Linux PCI core?
In-Reply-To: <20130207165009.73b1f340@skate>
References: <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de>
 <20130206175019.GA24248@obsidianresearch.com> <20130207165009.73b1f340@skate>
Message-ID: <201302072333.12010.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 February 2013, Thomas Petazzoni wrote:
> I am unfortunately starting to believe that using the standard PCI
> resource allocator is too complicated for our hardware, and that we
> should maybe have a dedicated allocator. But I would really like to
> avoid that if possible.

I see this just as more evidence that the emulated P2P bridge approach
is not the easiest solution and that it would be easier to go back
to adding the ports separately and make it possible to have every
port assign the BARs first and then set the resources based on
the physical address of the window we pick for it.

	Arnd
