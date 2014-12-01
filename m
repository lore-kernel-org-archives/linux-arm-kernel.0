From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 1 Dec 2014 10:41:45 +0000
Subject: [PATCH] irqchip: gic: Allow interrupt level to be set for PPIs.
In-Reply-To: <1417197340-27298-1-git-send-email-Liviu.Dudau@arm.com>
References: <1417197340-27298-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <20141201104145.GY3836@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 28, 2014 at 05:55:40PM +0000, Liviu Dudau wrote:
> +	/*
> +	 * PPIs are optionally configurable, but we cannot distinguish
> +	 * between high and low, nor falling and rising. Change the
> +	 * type so that it passes the next check.

This comment could do with a /lot/ of improvement.  It sounds like the
only reason this code exists is to bypass the check.  If that's all
that's being done, there's better ways to code it.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
