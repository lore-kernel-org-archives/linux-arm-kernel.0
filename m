From: vgoyal@redhat.com (Vivek Goyal)
Date: Wed, 1 Oct 2014 13:47:14 -0400
Subject: [PATCH 6/7] arm64/kexec: Add core kexec support
In-Reply-To: <20141001161621.GA28440@leverpostej>
References: <cover.1411604443.git.geoff@infradead.org>
 <471af24b7de659a30a5941e793634bffec380cb9.1411604443.git.geoff@infradead.org>
 <20140930181840.GA24153@redhat.com>
 <1412106877.6630.45.camel@smoke>
 <20141001161621.GA28440@leverpostej>
Message-ID: <20141001174714.GD14991@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 01, 2014 at 05:16:21PM +0100, Mark Rutland wrote:

[..]
> I'm still rather unhappy about the mechanism by which the DTB is passed
> by userspace and detected by the kernel, as I'd prefer that the user
> explictly stated which segment they wanted to pass to the (Linux)
> kernel, but that would require reworking the kexec syscall to allow
> per-segment info/flags.

Why does the running kernel need to know about dtb segment.  I see following.

ldr     x0, kexec_dtb_addr

IIUC, we are loading this address in x0. Can't we do something similar
in user space with purgatory. I mean first jump to purgatory (code
compiled in user space but runs prviliged) and that code takes care
of loading x0 with right dtb addr and then jump to final kernel.

IOW, I am not able to understand that why kernel implementation needs
to know which is dtb segment.

Thanks
Vivek
