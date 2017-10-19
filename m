From: tony@atomide.com (Tony Lindgren)
Date: Thu, 19 Oct 2017 09:24:16 -0700
Subject: libbattery was Re: [RFC PATCH 5/5] power: generic-adc-battery:
 Add capacity handling
In-Reply-To: <0C0901E1-23E8-4D04-B3A9-8314809A7A6B@goldelico.com>
References: <1501620926-22669-1-git-send-email-marek.belisko@open-nandra.com>
 <1501620926-22669-6-git-send-email-marek.belisko@open-nandra.com>
 <20170829101147.debhadzyfrxhkrvt@earth>
 <20170908113231.GJ18365@amd> <20171018122804.GA14376@amd>
 <61BFA8AF-657A-4AD7-A7AC-3E5DC3B7E83D@goldelico.com>
 <20171018132204.GD4394@atomide.com>
 <0C0901E1-23E8-4D04-B3A9-8314809A7A6B@goldelico.com>
Message-ID: <20171019162416.GE4394@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* H. Nikolaus Schaller <hns@goldelico.com> [171018 08:49]:
> 
> > Am 18.10.2017 um 15:22 schrieb Tony Lindgren <tony@atomide.com>:
> > 
> > * H. Nikolaus Schaller <hns@goldelico.com> [171018 05:49]:
> >>> Am 18.10.2017 um 14:28 schrieb Pavel Machek <pavel@ucw.cz>:
> >>> 
> >>> So I started something, it is at.
> >>> 
> >>> https://github.com/pavelmachek/libbattery
> >>> 
> >>> My battery on n900 is currently uncalibrated (and charging), still it
> >>> gets some kind of estimation:
> >>> 
> >>> Battery -1 %
> >>> Seconds -1
> >>> State 1
> >>> Voltage 3.88 V
> >>> Battery 63 %
> >>> 
> >>> Of course, there's a lot more work to be done.
> >> 
> >> Nice start but not a solution to our problem.
> >> 
> >> Our problem is that people simply expect that for example https://packages.debian.org/wheezy/xfce/xfce4-battery-plugin
> >> displays the battery percentage.
> > 
> > I think we could make things compatible with various battery apps by
> > having libbattery write back the capacity percentage and time remaining
> > to the kernel driver via sysfs or a dev entry. Then the kernel interface
> > can just display the data to whatever apps.
> 
> Hm. That would be quite difficult to understand and maintain code.

How so? The libbattery can do it all, then the kernel drivers needing
that will just display the most recent values to maintain compability
with battery apps.

> Why not have the kernel driver do the simple calculations (they do
> not need float) and provide the standard /sys/class/power attribute?

Because the current remaining capacity and battery empty state depend
on maintaining a database of previous history for battery wear. This
data needs to be preserved across reboots, so most likely on a file
on a disk is the way to go.

There's a nice summary what all is involved here:

http://www.mpoweruk.com/soc.htm

Regards,

Tony
