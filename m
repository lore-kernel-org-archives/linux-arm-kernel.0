From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 26 Mar 2018 15:59:20 +0200
Subject: [Letux-kernel] [PATCH v5 3/5] misc serdev: Add w2sg0004 (gps
 receiver) power control driver
In-Reply-To: <FCD404C1-3DD4-45BD-9242-3F7A7C44F6C9@goldelico.com>
References: <5494ad34b39a6c62601e3747440268dfb3be7d5a.1512114576.git.hns@goldelico.com>
 <20171222124427.GI3374@localhost>
 <91850CC3-B280-4701-9D07-96AFF3A79A6F@goldelico.com>
 <90F9A8E4-035A-4A9E-8AAB-757491D63E69@goldelico.com>
 <20180112153903.GB5992@localhost> <20180212152618.GC13962@amd>
 <20180227070415.GB18666@localhost>
 <22A8F5FE-C8B9-46EB-B98D-A94EA4170131@goldelico.com>
 <20180319135418.GL18359@localhost>
 <FCD404C1-3DD4-45BD-9242-3F7A7C44F6C9@goldelico.com>
Message-ID: <20180326135920.GA1450@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > No, we need some kind of at least rudimentary gps framework even if we
> > allow for a raw (NMEA) interface for the time being (possibly
> > indefinitely).
> 
> Ok, that would be fine if we can get that!
> 
> For a minimal set of API I think something like this (following hci_dev) would suffice:
> 
> struct gps_dev {
> 	...
> 	int (*open)(struct gps_dev *gdev);
> 	int (*close)(struct gps_dev *gdev);
> 	int (*send)(struct gps_dev *gdev, char *data, int length);
> };
> 
> int gps_register_dev(struct gps_dev *gdev);
> void gps_unregister_dev(struct gps_dev *gdev);
> int gps_recv_nmea_chars(struct gps_dev *gdev, char *data, int length);
> 
> If that would wrap all creation of some /dev/ttyGPS0 (or however it is called),
> it would fit our needs for a driver and user-space for our system.
> 
> And I would be happy to get rid of creating and registering a /dev/ttyGPS0
> in the w2sg0004 driver.

Sounds like a good start.

Best regards,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180326/735b30ed/attachment.sig>
