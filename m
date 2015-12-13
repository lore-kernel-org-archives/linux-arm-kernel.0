From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Sun, 13 Dec 2015 16:59:42 +0000
Subject: [Linaro-acpi] Touching the initrd before paging_init
In-Reply-To: <566D3090.9090509@redhat.com>
References: <566D3090.9090509@redhat.com>
Message-ID: <20151213165942.GN25034@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 13, 2015 at 03:47:12AM -0500, Jon Masters wrote:
> I mentioned before that we'll want to see ACPI_INITRD_TABLE_OVERRIDE
> support on arm64 in due course for use during bringup of new systems. It
> is commonly used on x86 to provide handy updated ACPI tables via a
> prepended initrd cpio that is attached to the regular initrd image,
> which is infinitely better than respinning firmware each time you want
> to provide updated tables (yes yes, we all know the "devicetree"
> directive in GRUB does this with DT and that's great and wonderful). I
> know that someone is working on it, but I had a need for an interim
> solution over the weekend for some hardware I am bringing up here.

Why would we do this through an initrd?
That sounds an awful lot like the per-kernel-image dtbs that are the whole
thing we're trying to avoid.

Implementing this as a grub command (or kernel command line) for debug
purposes would be trivial - and I'm pretty sure Graeme/Al already did
this in the past.

/
    Leif
