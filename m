From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Mon, 04 Nov 2013 15:49:59 +0100
Subject: pci-mvebu driver on km_kirkwood
In-Reply-To: <20130826191615.GA20192@obsidianresearch.com>
References: <51DD88A4.1030506@keymile.com> <20130731100359.3e789236@skate>
 <51F8CA44.4080802@keymile.com> <20130731110045.2dc84981@skate>
 <20130731205034.GA17615@obsidianresearch.com> <20130809140140.GA14990@ulmo>
 <521B1F6A.1090304@keymile.com> <20130826120200.GA15842@ulmo>
 <521B6AF3.9070909@keymile.com> <20130826191615.GA20192@obsidianresearch.com>
Message-ID: <5277B417.2030506@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi folks,

thank you for your patience...

So, thanks to Thierry's example:

 > 
https://gitorious.org/thierryreding/linux/commit/b85c03d73288f6e376fc158ceac30f29680b4192

and Jason's explanation:

 > The reg must encode the bus number according to the OF format:
 >
 >                 33222222 22221111 11111100 00000000
 >                 10987654 32109876 54321098 76543210
 >   phys.hi cell: npt000ss bbbbbbbb dddddfff rrrrrrrr
 > phys.mid cell: hhhhhhhh hhhhhhhh hhhhhhhh hhhhhhhh
 >   phys.lo cell: llllllll llllllll llllllll llllllll
 >
 > bbbbbbbb is the 8-bit Bus Number
 > ddddd is the 5-bit Device Number
 > fff is the 3-bit Function Number
 >
 > Others are 0.

I'm finally starting to make some sense out of this, and I checked that 
Jason's statement is indeed true, at least on 3.10:

 > Device tree can include the discovered PCI devices, you have to use
 > the special reg encoding and all that weirdness, but it does work. The
 > of_node will be attached to the struct pci device automatically.

[Hi latency was also due to other activities, not just the low 
throughput of my brain cells] ;-)

I have one last question for Thierry though: what's the point of things 
such as

+					pci at 0,0 {
+						compatible = "opencores,spi";

(apart from clarity, of course)?
I mean, wouldn't the driver be bound to the device through its PCI 
vendor ID / device ID?
Are we also supposed to register a platform driver based on a compatible 
string instead?

Thanks again guys!
Gerlando
