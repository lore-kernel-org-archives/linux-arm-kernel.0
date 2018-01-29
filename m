From: will.deacon@arm.com (Will Deacon)
Date: Mon, 29 Jan 2018 15:48:12 +0000
Subject: [PATCH v1] arm64: setup: Check for overlapping dtb and Image
 load addresses
In-Reply-To: <20180124092345.5072-1-clingutla@codeaurora.org>
References: <20180124092345.5072-1-clingutla@codeaurora.org>
Message-ID: <20180129154812.GA25061@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 24, 2018 at 02:53:45PM +0530, Lingutla Chandrasekhar wrote:
> Sometime kernel image and dtb load offsets can overlap due to
> dynamically increased Image or dtb size if both load addresses
> are near to each other, which leads to bootup failures.
> 
> So validate dtb load address and kernel image, if they overlap
> do not proceed to boot.
> 
> Signed-off-by: Lingutla Chandrasekhar <clingutla@codeaurora.org>
> ---
> 
> Changes since v0:
> - Print overlap bytes.
> - Simplify ovelap checks.

This all feels a bit fragile to me, since we're relying on some portion of
the Image and .dtb working in order to run this code successfully.  I'd
rather not pretend to detect this exact scenario, particularly as I can't
see it being useful for anybody other than firmware developers (who are in a
better position to check whether or not this is happening).

More generally, is there not some .dtb checksum failure that detects
corruption there? Perhaps we could do something like that for the Image
too?

Will
