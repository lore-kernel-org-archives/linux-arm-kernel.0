From: denis@eukrea.com (Denis Carikli)
Date: Wed, 25 Jun 2014 10:51:24 +0200
Subject: [PATCH v2 1/2] video: imxfb: Fix unbalanced regulators
In-Reply-To: <20140625060848.GE15686@pengutronix.de>
References: <1403528839-31901-1-git-send-email-denis@eukrea.com>
 <20140625060848.GE15686@pengutronix.de>
Message-ID: <53AA8D8C.2040705@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25/2014 08:08 AM, Sascha Hauer wrote:
> It's a shame that the LCD controller doesn't do the reference counting.
> I really think it should be fixed there and not in the drivers.If for
> whatever reason this is not acceptable then it should be done in the
> imxfb driver instead of shifting it further to the regulator core.
I'm not sure that doing reference counting in the LCD class would be 
enough for the regulator case. Still it seems to be a good thing to do.

If I understood well, that assumes that the LCD driver is the only 
consumer and owner of that regulator.

There is also the fact that the regulator core also enables or disables 
regulators by itself:
For instance at boot it tries to disable the regulators that can be 
disabled, including this regulator.

So I don't see any ways to handle it correctly in the LCD.

Denis.
