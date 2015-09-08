From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Sep 2015 23:19:13 +0100
Subject: [PATCH v2 1/3] ARM: Make FORCE_MAX_ZONEORDER configurable if
 ARM_SINGLE_ARMV7M
In-Reply-To: <1441744686-20521-2-git-send-email-mcoquelin.stm32@gmail.com>
References: <1441744686-20521-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1441744686-20521-2-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <20150908221912.GE21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 08, 2015 at 10:38:04PM +0200, Maxime Coquelin wrote:
> This patch makes FORCE_MAX_ZONEORDER configurable in defconfig for ARMV7-M
> when built for a single platform.

I'd prefer if we didn't do this, because this isn't supposed to be a user
visible "option".  It's an option that was introduced to avoid having to
throw masses of #ifdefs into the definition of MAX_ZONEORDER.

The problem with it is that it's a "well, what do I set this to?" option
and that leads to "oh, I'll just choose the default because I don't know
any better".

Do we know why EFM32 needs a value of 9 here?  It's not documented in
the original commit, and it really _should_ have been.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
