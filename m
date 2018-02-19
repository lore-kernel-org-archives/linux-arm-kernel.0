From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 19 Feb 2018 20:04:54 +0100
Subject: v4.13 on nokia n900: oops during tethering
In-Reply-To: <20180213222412.GA1116@mara.localdomain>
References: <20180212201000.GA25608@amd>
 <20180213222412.GA1116@mara.localdomain>
Message-ID: <20180219190454.GB19366@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> On Mon, Feb 12, 2018 at 09:10:00PM +0100, Pavel Machek wrote:
> > Hi!
> > 
> > During tethering, I got oops in ssi_stop_tx(), followed by failure of
> > GPRS. I used GPRS tethering a lot with some older kernel, and it was
> > stable for hours.
> > 
> > It seems v4.12 has the same problem. In v4.15 usb networking does not
> > work at all, so I can't test... v4.10 seems to have similar problem. (Testing is
> > slighlty tricky, as my internet connection is ... tethering using
> > N900.)
> 
> Based on a quick look ssi_stop_tx() is called too many times (i.e. once
> more than ssi_start_tx()). This would appear to be an interal problem
> with the SSI codebase (or whatever lies there; I don't know the current
> codebase).

If I change BUG_ON in ssi_stop_tx() to warning and return, I see the
warning and system survives it.

> Did this work in the past? When? There appear to have been changes in IRQ
> handling some time in 2016...

Actually, I'm not sure any more :-(. I did have tethering running
overnight some time ago, but it was on slower mobile data, and over
wifi.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180219/6c1dd7c4/attachment-0001.sig>
