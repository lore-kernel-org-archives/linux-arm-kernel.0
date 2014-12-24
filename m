From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 24 Dec 2014 17:20:38 +0000
Subject: [PATCH] ARM: mm: Enable PXN when running non-LPAE kernel on LPAE
 processor
In-Reply-To: <1419436468.4705.105.camel@decadent.org.uk>
References: <1419436468.4705.105.camel@decadent.org.uk>
Message-ID: <20141224172038.GE13399@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 24, 2014 at 03:54:28PM +0000, Ben Hutchings wrote:
> The VMSA field of MMFR0 (bottom 4 bits) is incremented for each
> added feature.  PXN is supported if the value is >= 4 and LPAE
> is supported if it is >= 5.
> 
> In case a kernel with CONFIG_ARM_LPAE disabled is used on a
> processor that supports LPAE, we can still use PXN in short
> descriptors.  So check for >= 4 not == 4.
> 
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> Cc: Jungseung Lee <js07.lee@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
