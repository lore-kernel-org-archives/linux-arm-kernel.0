From: panand@redhat.com (Pratyush Anand)
Date: Fri, 27 Nov 2015 18:43:06 +0530
Subject: [PATCH v12 08/16] arm64/kexec: Add core kexec support
In-Reply-To: <6ac232ad37d6b02cf2d5848b15236f26f5ac61ac.1448403503.git.geoff@infradead.org>
References: <cover.1448403503.git.geoff@infradead.org>
 <6ac232ad37d6b02cf2d5848b15236f26f5ac61ac.1448403503.git.geoff@infradead.org>
Message-ID: <20151127131306.GE23908@dhcppc13.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff,

On 24/11/2015:10:25:34 PM, Geoff Levand wrote:
> +	/* Test the entry flags. */
> +.Ltest_source:
> +	tbz	x18, IND_SOURCE_BIT, .Ltest_indirection
> +
> +	mov x20, x13				/*  x20 = copy dest */
> +	mov x21, x12				/*  x21 = copy src */

Till v10 we had here invalidation for relocated destination page to PoC. I could
not understand, why it was removed. Removing that piece of code breaks kexec
booting with mustang. I need [1] to kexec boot into second kernel with mustang
platform.

[1]
https://github.com/pratyushanand/linux/commit/431e3247391981a1e8b2864a83a5743e8a274cb9

~Pratyush
