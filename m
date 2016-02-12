From: jeremy.linton@arm.com (Jeremy Linton)
Date: Fri, 12 Feb 2016 12:09:41 -0600
Subject: [PATCH 2/2] arm64: Mark kernel page ranges contiguous
In-Reply-To: <20160212175857.GE20262@leverpostej>
References: <1455293208-6763-1-git-send-email-jeremy.linton@arm.com>
 <1455293208-6763-3-git-send-email-jeremy.linton@arm.com>
 <20160212165707.GB20262@leverpostej> <56BE17C9.6090608@arm.com>
 <20160212175857.GE20262@leverpostej>
Message-ID: <56BE1FE5.8080002@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/2016 11:58 AM, Mark Rutland wrote:

(trimming)

> All create_mapping_late() calls should be performed with the same
> physical/virtual start/end as earlier "chunk" mappings, and thus should
> never result in a fuse/split or translation change -- only permission
> changes (which we believe do not result in TLB conflicts, or we'd need
> to do far more work to fix those up).
>
> If we split/fuse in any case other than EFI runtime table creation, that
> is a bug that we need to fix. If you're seeing a case we do that, then
> please let me know!

We are saying the same thing, and right now the biggest violator is 
probably the .rodata patch I just posted!
