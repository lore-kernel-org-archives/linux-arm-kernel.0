From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Jan 2011 18:01:46 +0000
Subject: [PATCH] ARM: mm: Regarding section when dealing with meminfo
In-Reply-To: <1295544047.9039.609.camel@nimitz>
References: <1295516739-9839-1-git-send-email-pullip.cho@samsung.com>
	<1295544047.9039.609.camel@nimitz>
Message-ID: <20110120180146.GH6335@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 20, 2011 at 09:20:47AM -0800, Dave Hansen wrote:
> This problem actually exists without sparsemem, too.  Discontigmem (at
> least) does it as well.

We don't expect banks to cross sparsemem boundaries, or the older
discontigmem nodes (esp. as we used to store the node number.)
Discontigmem support has been removed now so that doesn't apply
anymore.

> The x86 version of show_mem() actually manages to do this without any
> #ifdefs, and works for a ton of configuration options.  It uses
> pfn_valid() to tell whether it can touch a given pfn.

x86 memory layout tends to be very simple as it expects memory to
start at the beginning of every region described by a pgdat and extend
in one contiguous block.  I wish ARM was that simple.
