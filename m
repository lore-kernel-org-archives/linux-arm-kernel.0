From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 08 Aug 2014 17:39:00 +0100
Subject: [PATCH 2/5] char: tile-srom: Remove reference to platform_bus
In-Reply-To: <1407515691.31897.26.camel@hornet>
References: <1406298233-27876-1-git-send-email-pawel.moll@arm.com>
 <1406298233-27876-2-git-send-email-pawel.moll@arm.com>
 <53DAA605.2030500@tilera.com> <1406913678.22529.46.camel@hornet>
 <53E139C8.9000502@tilera.com> <1407515691.31897.26.camel@hornet>
Message-ID: <1407515940.31897.31.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-08-08 at 17:34 +0100, Pawel Moll wrote:
> On Tue, 2014-08-05 at 21:08 +0100, Chris Metcalf wrote:
> > >> In addition, we also have user binaries
> > >> in the wild that know to look for /sys/devices/platform/srom/ paths,
> > >> so I'm pretty reluctant to change this path without good reason.
> > > So what is the srom class for then if not for device discovery? And why
> > > do they look for them in the first place? To get relevant character
> > > device's data, if I understand it right?
> > >
> > > Maybe you could just register a simple "proper" platform device for all
> > > the sroms and then hang the class devices from it? I can type some code
> > > doing this if it sound reasonably?
> > 
> > I'm not sure exactly what you mean by device discovery here.  

(sorry, sent too early...)

By "device discovery" I meant the way you find the way in your devices
in /sysfs. You seem to be traversing /sys/devices/... tree, while you've
got almost direct access to them through /sys/class/srom and you can (I
believe, correct me if I'm wrong, Greg) rely on this path being stable.

Pawe?
