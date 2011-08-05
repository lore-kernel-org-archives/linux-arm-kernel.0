From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Aug 2011 10:23:23 +0100
Subject: [PATCH 01/12] ARM: Remove LATCH reference for time-acorn.c
In-Reply-To: <20110804134437.GB919@plexity.net>
References: <cover.1312455035.git.dsaxena@linaro.org>
	<20110804134437.GB919@plexity.net>
Message-ID: <20110805092323.GB20575@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04, 2011 at 06:44:37AM -0700, Deepak Saxena wrote:
> +#define ACORN_TICK_RATE         2000000
> +#define ACORN_TIMER_LATCH	((CLOCK_TICK_RATE + HZ/2) / HZ)

And also these should all be DIV_ROUND_CLOSEST(xxx_TICK_RATE, HZ)
