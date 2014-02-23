From: shangw@linux.vnet.ibm.com (Gavin Shan)
Date: Sun, 23 Feb 2014 11:43:27 +0800
Subject: pci-mvebu driver on km_kirkwood
In-Reply-To: <1393012403.6771.89.camel@pasglop>
References: <53046D98.6020801@keymile.com> <20140219102658.76eec91e@skate>
 <53047BBB.6040108@keymile.com> <20140219143749.65ff3155@skate>
 <CAErSpo4=6VgJazaErcx=ztKhZ_62xBrQ6K1eN_dVpvV4R0T2ag@mail.gmail.com>
 <20140220095518.7ca36f0a@skate>
 <CAErSpo5pG3eOG58MiCCOHgr_jQReH0uBnWQFvzQYg3qrOGpZEw@mail.gmail.com>
 <20140221002438.GE19893@obsidianresearch.com>
 <CAErSpo5c=iMHM_uATxsiUthaHtt-UvX6ySQx2pVgfJT4ABuWGQ@mail.gmail.com>
 <1393012403.6771.89.camel@pasglop>
Message-ID: <20140223034327.GA13040@shangw.(null)>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 22, 2014 at 06:53:23AM +1100, Benjamin Herrenschmidt wrote:
>On Fri, 2014-02-21 at 12:05 -0700, Bjorn Helgaas wrote:
>> But I wonder if powerpc has a similar issue here: I think EEH might
>> need, for example 16MB bridge window alignment.  Since
>> pcibios_window_alignment() only affects the *starting* address, could
>> the core assign a 9MB window whose starting address is 16MB-aligned?
>> Could EEH deal with that?  What if the PCI core assigned the space
>> right after the 9MB window to another device?
>
>Gavin, did you guys deal with that at all ? Are we aligning the size as
>well somewhat ?
>

Yeah, we can handle it well because pcibios_window_alignment() affects
both starting address and size of PCI bridge window. More details could
be found in pci/drivers/setup-bus.c::pbus_size_mem(): starting address,
"size0", "size1", "size1-size0" are aligned to "min_align", which is
coming from pcibios_window_alignment() (16MB as mentioned).

Thanks,
Gavin
