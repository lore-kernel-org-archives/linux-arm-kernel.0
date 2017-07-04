From: slash.tmp@free.fr (Mason)
Date: Wed, 5 Jul 2017 01:42:47 +0200
Subject: [PATCH v9 2/3] PCI: Add tango PCIe host bridge support
In-Reply-To: <20170704155855.GI13824@bhelgaas-glaptop.roam.corp.google.com>
References: <987fac41-80dc-f1d0-ec0b-91ae57b91bfd@sigmadesigns.com>
 <b32f9e1c-fdde-3064-f935-c817cf707534@sigmadesigns.com>
 <20170702231811.GJ18324@bhelgaas-glaptop.roam.corp.google.com>
 <79382219-c730-da78-3e5f-5abf3173d7ac@sigmadesigns.com>
 <20170703134031.GG13824@bhelgaas-glaptop.roam.corp.google.com>
 <16622817-8ccd-107b-be08-676b576f6e8a@sigmadesigns.com>
 <20170704155855.GI13824@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <877fefdf-969d-bc46-3233-f988ccfe4c74@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07/2017 17:58, Bjorn Helgaas wrote:

> It's definitely a hassle to support chips with different register
> layouts.  Your hardware guys are really making your life hard :)

Now where did I put my foam bat...

> If the chips are fundamentally different, i.e., if they *operate*
> differently in addition to having a different register layout, you
> could make two separate drivers.

It's the exact same underlying IP. Revision 2 is only a
bug fix rev. IIUC, some of the fixes lead to adding a
register here, removing a register there... and I don't
think the HW dev ever considered the pain of supporting
both revs within a single driver.

This dual support explains some of the peculiarities
you noted in my submission.

Regards.
