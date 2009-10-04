From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 4 Oct 2009 13:24:56 +0100
Subject: [PATCH 5/6] Add checks to detect overlap of memory regions.
In-Reply-To: <1254394141-26673-6-git-send-email-andreas.fenkart@streamunlimited.com>
References: <20090810213905.GA4046@n2100.arm.linux.org.uk>
	<1254394141-26673-1-git-send-email-andreas.fenkart@streamunlimited.com>
	<1254394141-26673-2-git-send-email-andreas.fenkart@streamunlimited.com>
	<1254394141-26673-3-git-send-email-andreas.fenkart@streamunlimited.com>
	<1254394141-26673-4-git-send-email-andreas.fenkart@streamunlimited.com>
	<1254394141-26673-5-git-send-email-andreas.fenkart@streamunlimited.com>
	<1254394141-26673-6-git-send-email-andreas.fenkart@streamunlimited.com>
Message-ID: <20091004122456.GD26794@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 01, 2009 at 12:49:00PM +0200, Andreas Fenkart wrote:
> +	/*
> +	 * Check boundaries twice: Some fundamental inconsistencies can
> +	 * be detected at build time already.
> +	 */
> +	BUILD_BUG_ON(VMALLOC_START			>= VMALLOC_END);
> +	BUG_ON(VMALLOC_START				>= VMALLOC_END);

This one is now guaranteed by other parts of the code, and doesn't
need to be checked anymore - we enforce a minimum size of 32M for
the vmalloc region now.
