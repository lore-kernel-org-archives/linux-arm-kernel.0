From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 12 Feb 2018 16:25:47 +0100
Subject: [Letux-kernel] [PATCH v5 3/5] misc serdev: Add w2sg0004 (gps
 receiver) power control driver
In-Reply-To: <90F9A8E4-035A-4A9E-8AAB-757491D63E69@goldelico.com>
References: <cover.1512114576.git.hns@goldelico.com>
 <5494ad34b39a6c62601e3747440268dfb3be7d5a.1512114576.git.hns@goldelico.com>
 <20171222124427.GI3374@localhost>
 <91850CC3-B280-4701-9D07-96AFF3A79A6F@goldelico.com>
 <90F9A8E4-035A-4A9E-8AAB-757491D63E69@goldelico.com>
Message-ID: <20180212152547.GA13962@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >> I'm sorry (and I know this discussion has been going on for a long
> >> time),but this still feels like too much of a hack.
> 
> Happy new year ... Happy new attempt...
> 
> Let's restart this discussion and focus on the main roadblock (others are minor
> details which can be sorted out later).
> 
> If it feels like a hack, the key issue seems to me to be the choice of
> the API to present the GPS data to user space. Right?
> 
> I see three reasonable options how this presentation can be done:
> 
> 1. char device
> 2. tty device
> 3. some new gps interface API (similar to network, bluetooth interfaces)
> 4. no driver and use the UART tty directly

> 3. some new gps interface API
> + could become very elegant and general
> - does not exist (AFAIK not even a plan but I am not aware of everything)
> - no user-space daemons and applications exist which use it

Yes, that is what needs to be done. It is very similar problem to
serial mice we used to have long time ago. (And it has pretty much
same solution; exporting NMEA for gpsd, then slowly moving to system
with no gpsd).

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180212/9b13e763/attachment.sig>
