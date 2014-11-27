From: ming.lei@canonical.com (Ming Lei)
Date: Thu, 27 Nov 2014 18:14:14 +0800
Subject: [RFC PATCH] ARM64: PCI: inherit root controller's dma-coherent
In-Reply-To: <2081877.zLc8dS8vkP@wuerfel>
References: <1417066891-16789-1-git-send-email-ming.lei@canonical.com>
 <2081877.zLc8dS8vkP@wuerfel>
Message-ID: <CACVXFVN=M6VX31QWVzFj8MwBskjc5aYe3zJmcM1OG9xj-Y_WOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 27, 2014 at 5:03 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> Regarding the pcibios_add_device() function, I'd rather see the existing
> code moved into the PCI core and the function removed, since it also
> is not architecture specific. We should be able to delete the entire
> arm64/pci.c file eventually.

I totally agree.

Looks pcibios_*() are misused by ARCHs, which should have been
designed for addressing ARCH pcibios things, now these functions
are just a hook for ARCH code.

Specifically pci host controller driver can't be arch independent
at all because of ARCH's pcibios_*() implementation and
the specific data type defined by ARCH code.

Thanks,
Ming Lei
