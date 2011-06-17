From: wim@iguana.be (Wim Van Sebroeck)
Date: Fri, 17 Jun 2011 09:14:39 +0200
Subject: [MPCore Watchdog]: Convert from misc_dev to dynamic device node.
In-Reply-To: <20110615085820.GH3075@pulham.picochip.com>
References: <BANLkTinaQpnVxwX5rB1jrabGX6ArvhhS7g@mail.gmail.com>
	<20110614234858.GA15534@gallagher>
	<BANLkTik02nt4ttTTS-3u5R_ZH0W90FADJQ@mail.gmail.com>
	<20110615085820.GH3075@pulham.picochip.com>
Message-ID: <20110617071439.GK23305@infomag.iguana.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

> On Tue, Jun 14, 2011 at 05:19:06PM -0700, Peter Fordham wrote:
> > > On Tue, Jun 14, 2011 at 04:29:26PM -0700, Peter Fordham wrote:
> > >> The current MPCore watchdog driver uses a misc_dev device node.
> > >> This patch changes it to use dynamically allocated device numbers.
> > >
> > > I'm not sure that this is the correct thing to do. ?All other watchdog devices
> > > use a miscdevice with a major:minor of 10:130, is there a specific reason
> > > that this node needs to be dynamic?
> > 
> > I was under the impressions that dynamic device nodes were the way of the
> > future. Is that not the case?
> 
> Well they are for new devices/subsystems but watchdog has an established 
> major:minor pair that all other devices use so you don't really have to 
> worry about a namespace clash.
> 
> > I'll add the relevant checks in other places as per your suggestions.
> 
> I've added Wim (watchdog driver maintainer), but I would think that if 
> this change is worth doing then it should be done for all drivers.
> 
> > > I believe the sysfs classes are pretty much
> > > deprecated now in preference of a bus too.
> > 
> > Can you give me some more info here? I thought the sysfs stuff was the
> > new right way of doing stuff. The class stuff allows udev to automatically
> > create the right device node.
> 
> So here's one that I'm aware of https://lkml.org/lkml/2011/3/25/502.  So 
> there's nothing wrong with using sysfs and a bus, but certainly a bus is 
> preferred over a class.

My opinion: we stick with the /dev/watchdog interface, we don't go for dynamic
device nodes but go for a sysfs interface. And this for all drivers and via the
new watchdog API. (updated version will be sent out today). Makes no sense
to do this for every driver.

Kind regards,
Wim.
