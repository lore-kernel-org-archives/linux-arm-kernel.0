From: cl@linux.com (Christoph Lameter)
Date: Wed, 4 Nov 2015 09:28:34 -0600 (CST)
Subject: [PATCH] arm64: Increase the max granular size
In-Reply-To: <20151104145445.GL7637@e104818-lin.cambridge.arm.com>
References: <1442944788-17254-1-git-send-email-rric@kernel.org>
 <20151028190948.GJ8899@e104818-lin.cambridge.arm.com>
 <CAMuHMdWQygbxMXoOsbwek6DzZcr7J-C23VCK4ubbgUr+zj=giw@mail.gmail.com>
 <20151103120504.GF7637@e104818-lin.cambridge.arm.com>
 <20151103143858.GI7637@e104818-lin.cambridge.arm.com>
 <CAMuHMdWk0fPzTSKhoCuS4wsOU1iddhKJb2SOpjo=a_9vCm_KXQ@mail.gmail.com>
 <20151103185050.GJ7637@e104818-lin.cambridge.arm.com>
 <alpine.DEB.2.20.1511031724010.8178@east.gentwo.org>
 <20151104123640.GK7637@e104818-lin.cambridge.arm.com>
 <alpine.DEB.2.20.1511040748590.17248@east.gentwo.org>
 <20151104145445.GL7637@e104818-lin.cambridge.arm.com>
Message-ID: <alpine.DEB.2.20.1511040927510.18745@east.gentwo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 4 Nov 2015, Catalin Marinas wrote:

> BTW, assuming L1_CACHE_BYTES is 512 (I don't ever see this happening but
> just in theory), we potentially have the same issue. What would save us
> is that INDEX_NODE would match the first "kmalloc-512" cache, so we have
> it pre-populated.

Ok maybe add some BUILD_BUG_ONs to ensure that builds fail until we have
addressed that.
