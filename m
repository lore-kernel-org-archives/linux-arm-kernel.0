From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 20 Feb 2014 10:35:18 -0700
Subject: pci-mvebu driver on km_kirkwood
In-Reply-To: <20140220095518.7ca36f0a@skate>
References: <51DD9A8C.10608@keymile.com> <20130711163220.2b3adf38@skate>
 <53039894.10905@keymile.com> <20140218212751.07c2aeb5@skate>
 <53046D98.6020801@keymile.com> <20140219102658.76eec91e@skate>
 <53047BBB.6040108@keymile.com> <20140219143749.65ff3155@skate>
 <CAErSpo4=6VgJazaErcx=ztKhZ_62xBrQ6K1eN_dVpvV4R0T2ag@mail.gmail.com>
 <20140220095518.7ca36f0a@skate>
Message-ID: <20140220173518.GA19893@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 20, 2014 at 09:55:18AM +0100, Thomas Petazzoni wrote:

> Does that make sense? Keep in mind that I'm still not completely
> familiar with the PCI terminology, so maybe the above explanation does
> not use the right terms.

Stated another way, the Marvel PCI-E to PCI-E bridge config space has
a quirk that requires the window BARs to be aligned on their size and
sized to a power of 2.

The first requirement is already being handled by hooking through
ARM's 'align_resource' callback.

One avenue would be to have mvebu_pcie_align_resource return a struct
resource and manipulate the size as well. Assuming the PCI core will
accommodate that.

Jason
