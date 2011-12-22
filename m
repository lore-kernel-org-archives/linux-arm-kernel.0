From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 22 Dec 2011 18:13:59 +0000
Subject: [PATCH] ARM: S3C64XX: Add basic cpuidle driver
In-Reply-To: <201112061231.22570.heiko@sntech.de>
References: <1323117169-9817-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <201112061231.22570.heiko@sntech.de>
Message-ID: <20111222181359.GA19259@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2011 at 12:31:21PM +0100, Heiko St?bner wrote:

> My S3C2416 playground is quite similar in its low power modes and their wakeup 
> sources and I've got a idle driver for it in a similar state sitting here.

Yeah, there's a lot of ARM systems look like this.

> So I'm really looking forward to seeing a possible example on how to support 
> the STOP and DEEP-STOP modes best.

My plan there for the s3c64xx was to use pm_domain to figure out if the
system is idle enough to drop down, I've been adding some pm_runtime
support to provide the information to the core to let it figure this out.
