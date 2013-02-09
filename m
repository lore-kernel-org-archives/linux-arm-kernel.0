From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 Feb 2013 12:06:31 +0000
Subject: [PATCH 11/17] ARM: fixup atags to be endian agnostic
In-Reply-To: <1360365467-25056-12-git-send-email-ben.dooks@codethink.co.uk>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
 <1360365467-25056-12-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20130209120631.GE17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 08, 2013 at 11:17:41PM +0000, Ben Dooks wrote:
> +	{ atag32_to_cpu(tag_size(tag_core)), atag32_to_cpu(ATAG_CORE) },
> +	{ atag32_to_cpu(1), atag32_to_cpu(PAGE_SIZE), atag32_to_cpu(0xff) },
> +	{ atag32_to_cpu(tag_size(tag_mem32)), atag32_to_cpu(ATAG_MEM) },
> +	{ atag32_to_cpu(MEM_SIZE) },
> +	{ atag32_to_cpu(0), atag32_to_cpu(ATAG_NONE) }

Again, this needs to be cpu_to_atag32().

Pay attention to what you're converting from and to.  Consider them
totally separate types that just happen to be integers, and ensure
that you match the types in your functions.
