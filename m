From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Nov 2015 19:00:03 +0000
Subject: [PATCH v2 10/12] ARM: only consider memblocks with NOMAP cleared
 for linear mapping
In-Reply-To: <1447698757-8762-11-git-send-email-ard.biesheuvel@linaro.org>
References: <1447698757-8762-1-git-send-email-ard.biesheuvel@linaro.org>
 <1447698757-8762-11-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20151116190003.GG8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 07:32:35PM +0100, Ard Biesheuvel wrote:
> Take the new memblock attribute MEMBLOCK_NOMAP into account when
> deciding whether a certain region is or should be covered by the
> kernel direct mapping.

It's probably worth looking at this as a replacement to the way
arm_memblock_steal() works, provided NOMAP doesn't result in the
memory being passed to the kernel allocators.  Thoughts?

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
