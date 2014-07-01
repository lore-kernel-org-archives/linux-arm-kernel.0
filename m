From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Jul 2014 13:15:44 +0100
Subject: [PATCH] mach-bcm SMC: address clang inline asm incompatibility
In-Reply-To: <1404216339-6480-1-git-send-email-elder@linaro.org>
References: <1404216339-6480-1-git-send-email-elder@linaro.org>
Message-ID: <20140701121544.GK32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 01, 2014 at 07:05:39AM -0500, Alex Elder wrote:
> My GCC-based build environment likes to call register r12 by the
> name "ip" in inline asm.  Behan Webster informed me that his Clang-
> based build environment likes "r12" instead.

Two objections, one of which is an acceptable outcome:
1. Why can't clang just learn these alternative names?
2. Why can't we just use "r12" here?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
