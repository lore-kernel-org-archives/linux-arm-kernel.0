From: will.deacon@arm.com (Will Deacon)
Date: Thu, 2 Nov 2017 19:01:07 +0000
Subject: [PATCH 00/23] KAISER: unmap most of the kernel from userspace
 page tables
In-Reply-To: <20171031223146.6B47C861@viggo.jf.intel.com>
References: <20171031223146.6B47C861@viggo.jf.intel.com>
Message-ID: <20171102190106.GC22263@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

[+linux-arm-kernel]

On Tue, Oct 31, 2017 at 03:31:46PM -0700, Dave Hansen wrote:
> KAISER makes it harder to defeat KASLR, but makes syscalls and
> interrupts slower.  These patches are based on work from a team at
> Graz University of Technology posted here[1].  The major addition is
> support for Intel PCIDs which builds on top of Andy Lutomorski's PCID
> work merged for 4.14.  PCIDs make KAISER's overhead very reasonable
> for a wide variety of use cases.

I just wanted to say that I've got a version of this up and running for
arm64. I'm still ironing out a few small details, but I hope to post it
after the merge window. We always use ASIDs, and the perf impact looks
like it aligns roughly with your findings for a PCID-enabled x86 system.

Cheers,

Will
