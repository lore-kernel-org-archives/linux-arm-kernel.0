From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 26 Aug 2013 13:16:15 -0600
Subject: pci-mvebu driver on km_kirkwood
In-Reply-To: <521B6AF3.9070909@keymile.com>
References: <51DD88A4.1030506@keymile.com> <20130731100359.3e789236@skate>
 <51F8CA44.4080802@keymile.com> <20130731110045.2dc84981@skate>
 <20130731205034.GA17615@obsidianresearch.com>
 <20130809140140.GA14990@ulmo> <521B1F6A.1090304@keymile.com>
 <20130826120200.GA15842@ulmo> <521B6AF3.9070909@keymile.com>
Message-ID: <20130826191615.GA20192@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 26, 2013 at 04:49:23PM +0200, Gerlando Falauto wrote:

> One last question though... what does then the numbering ("@a,b")
> stand for? I assume if the output of a plain (i.e. no params)
> 'lspci' is

It is device,function, but it is only descriptive and not used by
Linux.
 
> I should only have a "pci at dd,f" node, with the bus numbering being
> imposed by the hierarchy after an actual probing, right?
> So the actual bus number is never listed in the device tree (whereas
> the "@device,function" is). Is that right?

The reg must encode the bus number according to the OF format:

               33222222 22221111 11111100 00000000
               10987654 32109876 54321098 76543210
 phys.hi cell: npt000ss bbbbbbbb dddddfff rrrrrrrr
phys.mid cell: hhhhhhhh hhhhhhhh hhhhhhhh hhhhhhhh
 phys.lo cell: llllllll llllllll llllllll llllllll
 
bbbbbbbb is the 8-bit Bus Number
ddddd is the 5-bit Device Number
fff is the 3-bit Function Number

Others are 0.

Jason
