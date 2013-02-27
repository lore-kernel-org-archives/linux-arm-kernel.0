From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 27 Feb 2013 11:53:54 +0000
Subject: [PATCH] arm64: fix padding computation in struct ucontext
In-Reply-To: <mvmy5ebt3ol.fsf@hawking.suse.de>
References: <mvmy5ebt3ol.fsf@hawking.suse.de>
Message-ID: <20130227115354.GB2293@MacBook-Pro.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 26, 2013 at 04:55:54PM +0000, Andreas Schwab wrote:
> The expression to compute the padding needed to fill the uc_sigmask field
> to 1024 bits actually computes the padding needed for 1080 bits.
> Fortunately, due to the 16-byte alignment of the following field
> (uc_mcontext) the definition in glibc contains enough bytes of padding
> after uc_sigmask so that the overall offsets and size match in both
> definitions.
> 
> Signed-off-by: Andreas Schwab <schwab@suse.de>

It looks like I messed the bits vs bytes. Luckily we have the 16-byte
alignment of the last element in ucontext. I'll send the patch upstream.

Thanks.

-- 
Catalin
