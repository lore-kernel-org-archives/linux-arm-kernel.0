From: Milo.Kim@ti.com (Kim, Milo)
Date: Wed, 9 Jan 2013 01:29:44 +0000
Subject: [PATCH] Allow Marvell SATA driver to work with
 LEDS_TRIGGER_IDE_DISK
In-Reply-To: <20130108200350.GX5075@titan.lakedaemon.net>
References: <1357668987-3610-1-git-send-email-josh.coombs@gmail.com>
 <20130108190657.GW5075@titan.lakedaemon.net>
 <CAMW5UfY2vKEJ7K8tLJ1+JeKsr_hxtUTva9HGJxLan6k+KGdmvg@mail.gmail.com>
 <20130108200350.GX5075@titan.lakedaemon.net>
Message-ID: <A874F61F95741C4A9BA573A70FE3998F69E12010@DQHE02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-leds-owner at vger.kernel.org [mailto:linux-leds-
> owner at vger.kernel.org] On Behalf Of Jason Cooper
> Sent: Wednesday, January 09, 2013 5:04 AM
> To: Josh Coombs
> Cc: cooloney at gmail.com; linux-kernel at vger.kernel.org; linux-
> ide at vger.kernel.org; rpurdie at rpsys.net; linux ARM; jgarzik at pobox.com;
> linux-leds at vger.kernel.org
> Subject: Re: [PATCH] Allow Marvell SATA driver to work with
> LEDS_TRIGGER_IDE_DISK
> 
> On Tue, Jan 08, 2013 at 02:18:04PM -0500, Josh Coombs wrote:
> > Would it make more sense to add a second trigger
> > for SATA instead?
> 
> I'll leave that up to the led guys, I just wanted to raise the point
> that the driver could logically support other types of disks, and we
> should come up with a migration path instead of adding capabilities
> ad-hoc.

I agree with Jason's suggestion. One more thing to consider.

If we replace the name, 'ide-disk' or 'ide_disk' with general one,
then we should change the value of 'default_trigger' under arch directory also.
LED trigger works if the name is matched with trigger name of LED device.

Thanks,
Milo
