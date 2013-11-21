From: tony@atomide.com (Tony Lindgren)
Date: Thu, 21 Nov 2013 12:46:55 -0800
Subject: [RFCv2 3/3] ARM: dts: N900: Add SSI information
In-Reply-To: <20131121022125.GA2445@earth.universe>
References: <1379277856-24571-1-git-send-email-sre@debian.org>
 <1379277856-24571-4-git-send-email-sre@debian.org>
 <20131121013858.GK10317@atomide.com>
 <20131121022125.GA2445@earth.universe>
Message-ID: <20131121204654.GB10023@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sebastian Reichel <sre@debian.org> [131120 18:22]:
> On Wed, Nov 20, 2013 at 05:38:59PM -0800, Tony Lindgren wrote:
> 
> In the public documentation of the omaps all SSI related stuff is
> missing and memory areas are marked as reserved. I could not find
> out how to receive the NDA version, so the following is purely
> speculation based on the code.
> 
> If I understand it right the HW looks like this:
> 
> +-----------------+
> |    GDD (DMA)    | <- this one is currently called ssi-controller
> +--------+--------+
> | Port 1 | Port 2 | <- these are currently called ssi-port
> +--------+--------+
> 
> I think the GDD part must be enabled while Port 1 or Port 2 is
> enabled. The last RFC driver from Carlos did not even split up the
> irq/memory areas into different platform devices, but just requested
> all of them in one ssi platform device.

Might be worth checking. If these blocks have the revision and SYSC
register in the beginning of their address space like all omap modules,
then they are completely separate blocks and can idle independently.

The fact that they have separate interrutps makes me think that's the
case, otherwise there would be just interrupt(s) at the ssi-controllel
level.

> > The other binding pieces can be added later on as they get are ready.
> 
> Sure. They are almost finished btw. I was able to get a gsm network
> scan.

That's great :)

Regards,

Tony
