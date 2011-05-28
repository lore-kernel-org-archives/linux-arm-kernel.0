From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 28 May 2011 08:17:10 +0100
Subject: [PATCH 2/2] ARM: S5P: Add 64bit PWM timer counter for sched_clock
In-Reply-To: <1306534210-32659-2-git-send-email-kgene.kim@samsung.com>
References: <1306534210-32659-1-git-send-email-kgene.kim@samsung.com>
	<1306534210-32659-2-git-send-email-kgene.kim@samsung.com>
Message-ID: <20110528071710.GU24876@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 27, 2011 at 03:10:10PM -0700, Kukjin Kim wrote:
> From: Sangbeom Kim <sbkim73@samsung.com>
> 
> Basically, PWM timer works with 33Mhz on S5P SoCs and counter
> overflow every 128 secs. So it is needed 64-bit counter for
> supporting proper sched_clock() by 32-bit timer. This patch
> handle overflow control and can solve the problem of suspend
> to resume

NAK.

This patch is a backwards step, and adds a hell of a lot of complexity
which should already be dealt with in generic code.

What is "problem of suspend to resume" exactly?
