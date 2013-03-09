From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 9 Mar 2013 09:58:49 +0100
Subject: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
In-Reply-To: <20130308191227.GA6551@avionic-0098.mockup.avionic-design.de>
References: <20130306121118.GA17079@avionic-0098.mockup.avionic-design.de>
 <20130306180946.GA2433@obsidianresearch.com>
 <20130307080832.GD3451@avionic-0098.mockup.avionic-design.de>
 <20130307174955.GC20840@obsidianresearch.com>
 <20130307194830.GA1811@avionic-0098.mockup.avionic-design.de>
 <20130307200235.GB20695@obsidianresearch.com>
 <20130307204726.GB1811@avionic-0098.mockup.avionic-design.de>
 <51392B4D.9040404@gmail.com>
 <20130308071443.GA5772@avionic-0098.mockup.avionic-design.de>
 <20130308165228.GB4094@obsidianresearch.com>
 <20130308191227.GA6551@avionic-0098.mockup.avionic-design.de>
Message-ID: <20130309095849.639f398e@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Thierry Reding,

On Fri, 8 Mar 2013 20:12:27 +0100, Thierry Reding wrote:

> Oh well. I don't like it, but if that's the way it has to be, then so be
> it.

I don't like it too much either, but it's not a big problem either. It
works, and satisfies the DT requirements reasonably.

> Any reason why the reg-names can't match the root port's node name
> so that it can be used directly instead of going through hoops to
> construct a string from extra parameters? Like below:
> 
> 	pcie-controller {
> 		regs = <...>;
> 		reg-names = ..., "pcie at 1,0", "pcie at 2,0";
> 
> 		pcie at 1,0 {
> 			...
> 		};
> 
> 		pcie at 2,0 {
> 			...
> 		};
> 	};

Yes, I thought about doing this, but in my driver, I also use the
"pcie0.0" string to request the address decoding window from the
mvebu-mbus driver. So I would anyway have to construct this "pciX.Y"
string. But if you feel like using "pcie at X,Y" for the reg-names is
better even if I still need to construct the "pcieX.Y" string, then I
will be perfectly ok with making this change.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
