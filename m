From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 15 Nov 2013 21:12:15 +0900
Subject: [RFC DTC PATCH] dtc: add symlink (-L) output to dtbs
In-Reply-To: <1384201760-16785-1-git-send-email-jason@lakedaemon.net>
References: <1384201760-16785-1-git-send-email-jason@lakedaemon.net>
Message-ID: <20131115121215.901EFC40885@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 11 Nov 2013 20:29:20 +0000, Jason Cooper <jason@lakedaemon.net> wrote:
> Consumers of the Linux kernel's build products are beginning to hardcode
> the filenames of the dtbs generated.  Since the dtb filenames are
> currently the dts filename s/dts/dtb/, this prevents the kernel
> community from renaming dts files as needed.
> 
> Let's provide a consistent naming structure for consumers to script
> against.  Or at least, as consistent as the dts properties themselves.
> 
> With this patch, adding the '-L' option to the dtc commandline will
> cause dtc to create a symlink to the generated dtb, using the board
> compatible string as the filename, eg:
> 
>   globalscale,mirabox.dtb -> armada-370-mirabox.dtb

This whole thread is just crazy. The filename is not an ABI. Anything
digging into the kernel build tree is a) wrong, and b) userspace tooling
consuming the kernel build products which is /not/ ABI and can be changed

If we want to have a tool or script for creating a well formed directory
full of .dtb files because it would be helpful to U-Boot or something
else, then that is fine. Make it part of the "make install" path.

g.
