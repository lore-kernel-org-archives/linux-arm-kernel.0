From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 12 Nov 2013 08:05:12 +0100
Subject: address translation for PCIe-to-localbus bridge
In-Reply-To: <20131111155050.96290C41ABB@trevor.secretlab.ca>
References: <527A1983.6020603@keymile.com>
 <20131106173649.GA25515@obsidianresearch.com>
 <20131106190308.01f7a4a9@skate>
 <20131106182457.GA25879@obsidianresearch.com>
 <20131111155050.96290C41ABB@trevor.secretlab.ca>
Message-ID: <20131112080512.3992b2e4@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Grant Likely,

On Mon, 11 Nov 2013 15:50:50 +0000, Grant Likely wrote:

> > So the mbus would register an address xlate for its node that is
> > called instead of ranges parsing. For the example in my last message
> > the FPGA driver would register an xlate that made addresses relative
> > to its own BAR0 address.
> 
> There are already bus-specific transations available. Take a look at
> struct of_bus in drivers/of/address.c

Hum, right, but unless I'm wrong the of_busses[] array of struct of_bus
is fixed in drivers/of/address.c, and as it is, there is no way for a
specific bus driver to provide its own struct of_bus. So that would
need to be extended, right?

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
