From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Aug 2014 10:07:55 +0100
Subject: VFP available on a single CPU in a dual-CPU complex
In-Reply-To: <CAGVrzcaX4n2rJko_Kny81jkzQbV6z5TmcA2coGrj6BU-ahiOTA@mail.gmail.com>
References: <CAGVrzcaX4n2rJko_Kny81jkzQbV6z5TmcA2coGrj6BU-ahiOTA@mail.gmail.com>
Message-ID: <20140815090755.GV30401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 14, 2014 at 09:45:09PM -0700, Florian Fainelli wrote:
> On Broadcom's BCM63138 SoC, the second Cortex A9 CPU does not have
> VFP, which is a problem as one might imagine because we currently
> assume it is available for all CPUs within the complex.

I really don't want to hear this.  This is not a symmetric system.
It's pretty broken.

Given that modern userspace assumes that VFP will always be available
as hardware instructions, this is not going to be nice.  It's probably
easier to ignore that non-VFP CPU1 and just treat it as a uniprocessor
system.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
