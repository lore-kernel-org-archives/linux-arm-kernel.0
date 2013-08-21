From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 21 Aug 2013 18:30:39 +0100
Subject: [PATCH] arm64: Expand arm64 image header
In-Reply-To: <1376521800-967-1-git-send-email-roy.franz@linaro.org>
References: <1376521800-967-1-git-send-email-roy.franz@linaro.org>
Message-ID: <20130821173038.GF6361@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 15, 2013 at 12:10:00AM +0100, Roy Franz wrote:
> Expand the arm64 image header to allow for co-existance with
> PE/COFF header required by the EFI stub.  The PE/COFF format
> requires the "MZ" header to be at offset 0, and the offset
> to the PE/COFF header to be at offset 0x3c.  The image
> header is expanded to allow 2 instructions at the beginning
> to accommodate a benign intruction at offset 0 that includes
> the "MZ" header, a magic number, and the offset to the PE/COFF
> header.
> 
> 
> Signed-off-by: Roy Franz <roy.franz@linaro.org>

The patch looks fine to me. I couldn't come up with a better magic
number in 4 bytes (something that would suggest Linux kernel). If you
have a better idea let me know before the merging window (LKA64 maybe?)

Thanks.

-- 
Catalin
