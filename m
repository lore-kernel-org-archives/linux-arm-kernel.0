From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 29 Nov 2012 16:34:49 +0000
Subject: [PATCH 2/2] i2c-s3c2410: Add bus arbitration implementation
In-Reply-To: <1354165536-18529-3-git-send-email-ch.naveen@samsung.com>
References: <1354165536-18529-1-git-send-email-ch.naveen@samsung.com>
 <1354165536-18529-3-git-send-email-ch.naveen@samsung.com>
Message-ID: <20121129163448.GA3761@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 29, 2012 at 10:35:35AM +0530, Naveen Krishna Chatradhi wrote:

> The arbitrator is a general purpose function which uses two GPIOs to
> communicate with another device to claim/release a bus. We use it to
> arbitrate an i2c port between the AP and the EC.

Should this not be layerd on top of the I2C controller rather than part
of the controller driver?  It doesn't seem terribly controller specific.
