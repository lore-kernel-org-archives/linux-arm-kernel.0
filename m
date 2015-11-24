From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Nov 2015 10:42:26 +0000
Subject: [RFC/PATCH 0/3] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <4485320.CGMJdfZLya@wuerfel>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <20151124001306.GI19156@codeaurora.org>
 <20151124085349.GQ19156@codeaurora.org>
 <4485320.CGMJdfZLya@wuerfel>
Message-ID: <20151124104225.GA8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2015 at 11:38:53AM +0100, Arnd Bergmann wrote:
> I suggested using -mcpu=cortex-a15 because there are old gcc versions
> that don't know about -march=armv7ve or -march=armv7-a+idiv yet, but
> that do understand -mcpu=cortex-a15.

That's not all.  The bigger problem is that there are toolchains out
there which accept these options, but do _not_ support IDIV in either
ARM or Thumb mode.  I'm afraid that makes it impossible to add this
feature to the mainline kernel in this form: we need to run a test
build to check that -march=armv7ve or what-not really does work
through both GCC and GAS.

Given that Ubuntu 14.04 LTS suffers with this, it's something that
must be resolved.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
