From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Jan 2015 19:12:10 +0000
Subject: [PATCH] i2c: drop ancient protection against sysfs refcounting
 issues
In-Reply-To: <1421693756-12917-1-git-send-email-wsa@the-dreams.de>
References: <1421693756-12917-1-git-send-email-wsa@the-dreams.de>
Message-ID: <20150119191210.GE26493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 19, 2015 at 07:55:56PM +0100, Wolfram Sang wrote:
> Back in the days, sysfs seemed to have refcounting issues and subsystems
> needed a completion to be safe. This is not the case anymore, so I2C can
> get rid of this code. There is noone else besides I2C doing something
> like this currently (checked with the attached coccinelle script which
> checks if a release function exists and if it contains a completion).

Have you validated this with DEBUG_KOBJECT_RELEASE enabled?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
