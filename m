From: sre@ring0.de (Sebastian Reichel)
Date: Fri, 22 Nov 2013 00:38:48 +0100
Subject: [RFCv2 3/3] ARM: dts: N900: Add SSI information
In-Reply-To: <20131121204654.GB10023@atomide.com>
References: <1379277856-24571-1-git-send-email-sre@debian.org>
 <1379277856-24571-4-git-send-email-sre@debian.org>
 <20131121013858.GK10317@atomide.com>
 <20131121022125.GA2445@earth.universe>
 <20131121204654.GB10023@atomide.com>
Message-ID: <20131121233847.GB9772@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 21, 2013 at 12:46:55PM -0800, Tony Lindgren wrote:
> * Sebastian Reichel <sre@debian.org> [131120 18:22]:
> > On Wed, Nov 20, 2013 at 05:38:59PM -0800, Tony Lindgren wrote:
> > 
> > In the public documentation of the omaps all SSI related stuff is
> > missing and memory areas are marked as reserved. I could not find
> > out how to receive the NDA version, so the following is purely
> > speculation based on the code.
> > 
> > If I understand it right the HW looks like this:
> > 
> > +-----------------+
> > |    GDD (DMA)    | <- this one is currently called ssi-controller
> > +--------+--------+
> > | Port 1 | Port 2 | <- these are currently called ssi-port
> > +--------+--------+
> > 
> > I think the GDD part must be enabled while Port 1 or Port 2 is
> > enabled. The last RFC driver from Carlos did not even split up the
> > irq/memory areas into different platform devices, but just requested
> > all of them in one ssi platform device.
> 
> Might be worth checking. If these blocks have the revision and SYSC
> register in the beginning of their address space like all omap modules,
> then they are completely separate blocks and can idle independently.

This does not seem to be the case.
I think this is just one big IP-Core, which provides two ports.

> The fact that they have separate interrutps makes me think that's the
> case, otherwise there would be just interrupt(s) at the ssi-controllel
> level.

The original driver from Carlos had all IRQs in one big platform
device. I created the ports subdevices, since it looked cleaner
than naming resources "port1_mpu_irq0".

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131122/60f08dbe/attachment.sig>
