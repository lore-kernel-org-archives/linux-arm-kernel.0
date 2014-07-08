From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 08 Jul 2014 16:24:34 +0200
Subject: [RFC PATCH 2/3] clk: samsung: register restart notifiers for
 s3c2412 and s3c2443
In-Reply-To: <1436436.XH2jFxzQOf@diego>
References: <1531376.ijR0PPyvmJ@diego> <1436436.XH2jFxzQOf@diego>
Message-ID: <53BBFF22.10904@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 06.07.2014 20:43, Heiko St?bner wrote:
> S3C2412, S3C2443 and their derivatives contain a special software-reset
> register in their system-controller.
> 
> Therefore register a restart-notifier for those.

I wonder if we really need to differentiate between these SoCs instead
of just using the watchdog reset for all of them. If there is no reason
to prefer software reset, then some code could be removed and things
would be more unified.

Best regards,
Tomasz
