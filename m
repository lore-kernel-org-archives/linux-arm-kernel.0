From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 18 Oct 2017 18:13:13 +0200
Subject: libbattery was Re: [RFC PATCH 5/5] power: generic-adc-battery:
 Add capacity handling
In-Reply-To: <341EC461-B19F-418C-B0BF-26E1EEFAD5B7@goldelico.com>
References: <1501620926-22669-1-git-send-email-marek.belisko@open-nandra.com>
 <1501620926-22669-6-git-send-email-marek.belisko@open-nandra.com>
 <20170829101147.debhadzyfrxhkrvt@earth>
 <20170908113231.GJ18365@amd> <20171018122804.GA14376@amd>
 <61BFA8AF-657A-4AD7-A7AC-3E5DC3B7E83D@goldelico.com>
 <20171018132204.GD4394@atomide.com> <20171018135656.GA26432@amd>
 <341EC461-B19F-418C-B0BF-26E1EEFAD5B7@goldelico.com>
Message-ID: <20171018161312.GA31392@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2017-10-18 17:52:22, H. Nikolaus Schaller wrote:
> 
> > Am 18.10.2017 um 15:56 schrieb Pavel Machek <pavel@ucw.cz>:
> > 
> > On Wed 2017-10-18 06:22:04, Tony Lindgren wrote:
> >> * H. Nikolaus Schaller <hns@goldelico.com> [171018 05:49]:
> >>>> Am 18.10.2017 um 14:28 schrieb Pavel Machek <pavel@ucw.cz>:
> >>>> 
> >>>> So I started something, it is at.
> >>>> 
> >>>> https://github.com/pavelmachek/libbattery
> >>>> 
> >>>> My battery on n900 is currently uncalibrated (and charging), still it
> >>>> gets some kind of estimation:
> >>>> 
> >>>> Battery -1 %
> >>>> Seconds -1
> >>>> State 1
> >>>> Voltage 3.88 V
> >>>> Battery 63 %
> >>>> 
> >>>> Of course, there's a lot more work to be done.
> >>> 
> >>> Nice start but not a solution to our problem.
> >>> 
> >>> Our problem is that people simply expect that for example https://packages.debian.org/wheezy/xfce/xfce4-battery-plugin
> >>> displays the battery percentage.
> >> 
> >> I think we could make things compatible with various battery apps by
> >> having libbattery write back the capacity percentage and time remaining
> >> to the kernel driver via sysfs or a dev entry. Then the kernel interface
> >> can just display the data to whatever apps.
> > 
> > Hmm. This could be as simple as providing symlink from
> > /sys/class/power/userland-battery to some place writable by
> > userspace...
> 
> Well, please implement arbitrary symlinks in /sysfs...

Any reason why I'd like to do that?
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171018/fb198e83/attachment.sig>
