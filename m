From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 5 Nov 2015 09:34:43 +0000
Subject: [PATCH RESEND 0/4] SMP support for Broadcom NSP
In-Reply-To: <1446702681-45339-1-git-send-email-kapilh@broadcom.com>
References: <1446702681-45339-1-git-send-email-kapilh@broadcom.com>
Message-ID: <20151105093443.GO8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 05, 2015 at 12:51:17AM -0500, Kapil Hali wrote:
> Hi,
> 
> This series adds SMP support for Broadcom's Northstar Plus SoC.
> 
> There are similar SMP enablement methods for many ARMv7 bsed SoCs.
> BCM NSP SoC, has a typical such mechanism - after power-on, the
> secondary core is held in a standby state, primary core provides a
> startup address for the secondary core and wakes it up. Booting of
> the secondary core is serialized using pen_release global variable.

Why do you need the pen_release stuff?  The above implies that you
have only one secondary core, and you can control when it comes out
of standby state.

Please, don't assume that the pen_release stuff is any kind of recommended
or standardised system.  It isn't.  It's a hack for ARMs evaluation
platforms.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
