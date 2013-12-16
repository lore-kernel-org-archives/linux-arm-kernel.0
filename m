From: ralf@linux-mips.org (Ralf Baechle)
Date: Mon, 16 Dec 2013 17:23:47 +0100
Subject: [PATCH 10/10] Kconfig: cleanup SERIO_I8042 dependencies
In-Reply-To: <1387040376-26906-11-git-send-email-msalter@redhat.com>
References: <1387040376-26906-1-git-send-email-msalter@redhat.com>
 <1387040376-26906-11-git-send-email-msalter@redhat.com>
Message-ID: <20131216162346.GA19285@linux-mips.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 14, 2013 at 11:59:36AM -0500, Mark Salter wrote:

> -	depends on !PARISC && (!ARM || FOOTBRIDGE_HOST) && \
> -		   (!SUPERH || SH_CAYMAN) && !M68K && !BLACKFIN && !S390 && \
> -		   !ARC
> +	depends on ARCH_MIGHT_HAVE_PC_SERIO

Most dependencies on an architecture's kconfig symbol outside arch/
should probably be treated as a bug.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
