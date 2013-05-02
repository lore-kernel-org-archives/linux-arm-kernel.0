From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 May 2013 19:02:37 +0100
Subject: [PATCH] arm: mm: Use phys_addr_t properly for ioremap functions
In-Reply-To: <1366761098-4485-1-git-send-email-lauraa@codeaurora.org>
References: <1366761098-4485-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <20130502180237.GY14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 23, 2013 at 04:51:38PM -0700, Laura Abbott wrote:
> -	unsigned long last_addr;
> - 	unsigned long offset = phys_addr & ~PAGE_MASK;
> +	phys_addr_t last_addr;
> +	phys_addr_t offset = phys_addr & ~PAGE_MASK;

BTW, this doesn't need to be phys_addr_t.  An offset of a page is always
less than 32-bits.
