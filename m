From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 8 Jul 2014 09:23:18 -0700
Subject: [RFC PATCH 2/3] clk: samsung: register restart notifiers for
 s3c2412 and s3c2443
In-Reply-To: <53BBFF22.10904@samsung.com>
References: <1531376.ijR0PPyvmJ@diego> <1436436.XH2jFxzQOf@diego>
 <53BBFF22.10904@samsung.com>
Message-ID: <20140708162318.GB9157@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 08, 2014 at 04:24:34PM +0200, Tomasz Figa wrote:
> Hi Heiko,
> 
> On 06.07.2014 20:43, Heiko St?bner wrote:
> > S3C2412, S3C2443 and their derivatives contain a special software-reset
> > register in their system-controller.
> > 
> > Therefore register a restart-notifier for those.
> 
> I wonder if we really need to differentiate between these SoCs instead
> of just using the watchdog reset for all of them. If there is no reason
> to prefer software reset, then some code could be removed and things
> would be more unified.
> 
Depends if the other method is always available. If not, it might make sense
to register this handler with lower priority to have a fallback.

Guenter
