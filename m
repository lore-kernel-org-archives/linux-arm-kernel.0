From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Aug 2011 20:22:13 +0100
Subject: [PATCH RFC v1] ARM: olpc: Add support for calling into the
	XO-1.75's OpenFirmware (OFW)
In-Reply-To: <20110804162551.2b92b2cf@debxo>
References: <20110804162551.2b92b2cf@debxo>
Message-ID: <20110805192213.GC28958@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04, 2011 at 04:25:51PM -0700, Andres Salomon wrote:
> Add support for saving OFW's cif, and later calling into it to run OFW
> commands from the kernel.  OFW remains resident in memory after boot,
> and the physical/virtual addresses are passed in a boot tag.

If you have open firmware, then you probably have a device tree being
passed to the kernel.  In that case, there aren't any boot tags being
passed.  So I think this patch is rather inconsistent.

Also I believe we had decided that ARM is not going to support the
runtime bits of DT/open firmware stuff.  Unless open firmware is aware
of the setup of the kernel mappings (which would then tie it directly
to the running kernel) it can't access any hardware resources.  I'm
not willing to have external binary blobs (whether or not the source
is available) having a dependency on the setup of the kernel page
tables.  Given that we are consolidating across all platforms, it's
likely that we will want to change the virtual address layout over time
and to have some external binary blob is just going to be a complete
nightmare.

So I really don't like this idea.  At all.
