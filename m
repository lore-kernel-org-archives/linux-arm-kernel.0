From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 Jun 2011 10:55:32 +0100
Subject: [PATCH 2/3] mach-u300: fix compilaton warning in IO accessors
In-Reply-To: <1306876133-6744-1-git-send-email-linus.walleij@stericsson.com>
References: <1306876133-6744-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110606095532.GD10508@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2011 at 11:08:53PM +0200, Linus Walleij wrote:
> +#ifdef __ASSEMBLER__
> +#define IOADD(a) (a)
> +#else
> +#define IOADD(a) (void __iomem *) a
> +#endif

Is there a reason this can't be called 'IOMEM' like other architectures
call it?
