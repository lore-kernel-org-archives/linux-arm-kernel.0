From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Jul 2015 10:45:07 +0100
Subject: [PATCH v3 3/3] arm: kernel: implement cpuidle_ops with psci
 backend
In-Reply-To: <20150727091602.GA10308@red-moon>
References: <20150714103421.GU7557@n2100.arm.linux.org.uk>
 <20150714110302.GA334@red-moon>
 <20150714122904.GV7557@n2100.arm.linux.org.uk>
 <20150714145546.GA14556@red-moon>
 <20150714204138.GW7557@n2100.arm.linux.org.uk>
 <20150715134603.GA14862@red-moon>
 <20150715144507.GZ7557@n2100.arm.linux.org.uk>
 <20150715154056.GA10418@red-moon>
 <20150726214554.GC7557@n2100.arm.linux.org.uk>
 <20150727091602.GA10308@red-moon>
Message-ID: <20150727094507.GD7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 27, 2015 at 10:16:02AM +0100, Lorenzo Pieralisi wrote:
> Yes, I would only ask you, if the plan above (which can be implemented
> in two steps) makes sense to you please consider accepting Mark's change
> to consolidate PSCI code into drivers/firmware/psci, it is a stepping stone
> without which the changes above can't happen, I will take charge of completing
> the move of CPUidle code and create the required shim layer into
> drivers to make this happen.

Why can't Jisheng Zhang base his patches on top of Mark's changes and
place the new file directly under drivers/ ?

Why do it as a two-step process with it first appearing in arch/arm,
and then having to generate another patch at a later date to move it
elsewhere.  That just creates more noise, and we should be avoiding
generating noise in arch/arm.

This is what Linus has said in his -rc4 release notes yesterday:

   Other than that issue, it's mostly drivers and networking.  USB, gpu,
   mmc, network drivers, sound. With some ARM noise (but even that is
   mostly driver-related: dts updates due to MMC fixes). And a few small
   filesystem fixes.

and we can infer from the phrase "ARM noise" that Linus' opinion of
arch/arm is still fairly low, and still doesn't regard the "churn" in
arch/arm as being useful.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
