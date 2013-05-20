From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Mon, 20 May 2013 05:30:17 +0000
Subject: [PATCH 1/2] ARM: OMAP AM33XX: clock data: Enable clkout2 as
 part of init
In-Reply-To: <alpine.DEB.2.00.1305200248280.2656@utopia.booyaka.com>
References: <1367919574-21353-1-git-send-email-hvaibhav@ti.com>
 <1367919574-21353-2-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1305200248280.2656@utopia.booyaka.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EC8E70F@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Paul Walmsley [mailto:paul at pwsan.com]
> Sent: Monday, May 20, 2013 8:20 AM
> To: Hiremath, Vaibhav
> Cc: linux-omap at vger.kernel.org; tony at atomide.com; Cousson, Benoit;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 1/2] ARM: OMAP AM33XX: clock data: Enable clkout2
> as part of init
> 
> On Tue, 7 May 2013, Vaibhav Hiremath wrote:
> 
> > clkout2 comes out on the pad and is being used by various
> > external on-board peripherals like, Audio codecs and stuff.
> > So enable the clkout2 by default during init sequence itself.
> 
> I don't like this: the clock should be enabled by the drivers for those
> external peripherals, not enabled by default.  

Neither do I. And certainly respective driver should make sure that
he enables all required clocks.

The gap here is, we only support DT only boot and currently clock bindings
Is not coming from DT. Once we get there this needs to change.

Also, note that, I do not expect impact on PM (atleast on AM335x).

> So I think you should
> reconsider the part of the patch that enables it upon init.  But if you
> really want to do this, I'm not inclined to stand in the way; you can
> add
> my ack.
> 

Thanks for your ack, I will send out next version shortly.

Thanks,
Vaibhav
