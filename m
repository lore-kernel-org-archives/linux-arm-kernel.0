From: vincent.whitchurch@axis.com (Vincent Whitchurch)
Date: Fri, 19 Oct 2018 11:00:29 +0200
Subject: [PATCH v2] ARM: Optimise copy_{from/to}_user for !CPU_USE_DOMAINS
In-Reply-To: <20181012131406.18601-1-vincent.whitchurch@axis.com>
References: <20181012131406.18601-1-vincent.whitchurch@axis.com>
Message-ID: <20181019090029.x4s7xn7u7ygs7dgx@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 12, 2018 at 03:14:06PM +0200, Vincent Whitchurch wrote:
> +	.macro ldr1b ptr reg cond=al abort
> +	USERL(\abort, ldr\cond\()b \reg, [\ptr], #1)
> +	.endm

This is broken on Thumb-2 since the fault handler is installed on the
implicitly-inserted IT instead of the LDR.  I will send a v3.
