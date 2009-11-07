From: matthew@wil.cx (Matthew Wilcox)
Date: Sat, 7 Nov 2009 08:03:05 -0700
Subject: [PATCH,RFC] PCI: deal with device incorrectly reporting I/O
	decoding being enabled
In-Reply-To: <20091107135615.GE18639@mail.wantstofly.org>
References: <20091107135615.GE18639@mail.wantstofly.org>
Message-ID: <20091107150305.GQ10555@parisc-linux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 07, 2009 at 02:56:15PM +0100, Lennert Buytenhek wrote:
> At least the Lava Quattro quad-port 16550A card can incorrectly report
> I/O decoding being enabled while it is in fact not, which means that
> the check in pcibios_enable_device() to see whether the new command
> word that we're intending to write into the device is different from
> the old current can trigger inadvertently, resulting in the write to
> enable I/O decoding never being done, and I/O decoding never being
> enabled.
> 
> Work around this by doing the write unconditionally (while still
> only doing the printk if the new word is different from the old one,
> to avoid dmesg spam).
> 
> Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
> --
> This is probably at least slightly controversial.  Any thoughts?

I'm OK with this ... it might provoke bugs in some _other_ piece of hardware,
but that seems pretty unlikely.

Reviewed-by: Matthew Wilcox <willy@linux.intel.com>

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
