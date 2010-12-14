From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 14 Dec 2010 17:30:07 +0000
Subject: [PATCH v4 4/5] msm: hotplug: support cpu hotplug on msm
In-Reply-To: <1292302233-16194-5-git-send-email-johlstei@codeaurora.org>
References: <1292302233-16194-1-git-send-email-johlstei@codeaurora.org>
	<1292302233-16194-5-git-send-email-johlstei@codeaurora.org>
Message-ID: <20101214173007.GA24303@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 13, 2010 at 08:50:32PM -0800, Jeff Ohlstein wrote:
> +static inline void platform_do_lowpower(unsigned int cpu)
> +{
> +	/* Just enter wfe for now. */
> +	for (;;) {
> +		asm("wfe" : : : "memory");
> +		if (pen_release == cpu) {
> +			/*
> +			 * OK, proper wakeup, we're done
> +			 */
> +			break;
> +		}
> +		smp_rmb();

I can't work out what this read memory barrier is doing here.  Could you
suggest what purpose it's serving please?
