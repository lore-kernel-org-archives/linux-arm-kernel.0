From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Sep 2012 14:41:45 +0100
Subject: [PATCH v3 RESEND 08/17] ARM: LPAE: use phys_addr_t in
 free_memmap()
In-Reply-To: <20120924132942.GD23298@arm.com>
References: <1348242975-19184-1-git-send-email-cyril@ti.com>
 <1348242975-19184-9-git-send-email-cyril@ti.com>
 <20120924132942.GD23298@arm.com>
Message-ID: <20120924134145.GB26454@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2012 at 02:29:42PM +0100, Catalin Marinas wrote:
> This function also calls free_bootmem() which takes unsigned long. Are
> patches sent separately for this or we just ignore holes in memmap?
> There are other calls to free_bootmem() or reserve_bootmem(), do they
> just work with the high phys addresses?

Bootmem only deals with physical addresses which fit within the size
of an 'unsigned long'.  Unfortunately, the bootmem API is a mess of
'unsigned long' physical addresses and PFNs.

Years ago there was a patch to make it use only PFNs but other changes
resulted in that patch being thrown away.
