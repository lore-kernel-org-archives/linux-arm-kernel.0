From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 1 Aug 2018 20:58:29 +0200
Subject: v4.18-rc2 on droid4: screen turns red
In-Reply-To: <20180717062608.GY99251@atomide.com>
References: <20180630131812.GA549@amd> <20180711102655.GA6864@amd>
 <20180717062608.GY99251@atomide.com>
Message-ID: <20180801185829.GD26087@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > After longer inactivity, attempt to wake up the screen results in
> > > screen being completely red. Not too useful. I can still connect over
> > > ssh.
> > 
> > Still there in -rc4 :-(. But happens only once in a few days for me...
> > 
> > When X is shut down, text console works ok.
> 
> FYI, I've been chasing an occasional hang with lapdock and it might
> be related to the usb phy switching between usb and uart mode
> spontaneously. And then the usb traffic can cause a sysrq trigger
> potentially when the glitch happens. Not sure yet why it happens, it
> might be related to lost cpcap interrupts still.
> 
> Anyways, so far looks like doing the following may have prevented
> it. Well at least for about four days of uptime now:
> 
> # echo 0 > /proc/sys/kernel/sysrq
> 
> And no red screens here yet either. Care to check if this might
> somehow also prevent your red screen issue?

Looks like red screens are pretty seldom :-(. I did not see it since
that report. (But I stopped using Droid 4 as my primary phone after it
lost some SMS.)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180801/a71a3ef4/attachment.sig>
