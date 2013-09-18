From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 18 Sep 2013 09:29:11 -0300
Subject: [PATCH 3/3] ARM: kirkwood: Move the nand node under the mbus node
In-Reply-To: <20130917184433.GF21230@obsidianresearch.com>
References: <20130917184433.GF21230@obsidianresearch.com>
Message-ID: <20130918122910.GA2563@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On Tue, Sep 17, 2013 at 12:44:33PM -0600, Jason Gunthorpe wrote:
> There should be no nodes that are not children of the mbus. Move
> the nand node under the mbus, and rework the board .dts files
> to use an & reference to the nand node.
> 

Thanks for taking the time to do this. However, notice this may
be not the accurate way of representing NAND in DT. The kirkwood
specification has a NAND Flash Registers section which speaks about
registers and they seem to match (to some extent) the MVEBU's Device Bus.

Therefore, my understanding is that NAND should be a child of a
'mvebu-devbus' compatible node in the device tree.

I haven't had time to investigate this any further and that's why
NAND hasn't been moved yet.

Maybe you can take a look at armada-xp.dtsi and armada-xp-openblocks-ax3-4.dts
to see how the devbus is handled now. You'll notice that Kirkwood's NAND window
IDs matches Armada 370/XP Device Bus BOOTCS window IDs.

What do you think?
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
