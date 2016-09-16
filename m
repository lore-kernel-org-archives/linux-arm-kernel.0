From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 16 Sep 2016 11:08:00 +0200
Subject: v4.8-rc: GSM audio causes trouble
In-Reply-To: <20160916055249.h7zw6hguvwwe2zwu@earth>
References: <20160915121755.GA5264@amd> <20160915205142.GA6747@amd>
 <20160916055249.h7zw6hguvwwe2zwu@earth>
Message-ID: <20160916090800.GA7599@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2016-09-16 07:52:50, Sebastian Reichel wrote:
> Hi,
> 
> On Thu, Sep 15, 2016 at 10:51:42PM +0200, Pavel Machek wrote:
> > > I was trying to improve GSM call quality, and hit problems in
> > > v4.8-rc. Sound only worked for a while, then I tried to kill
> > > cmtspeech_ofono_test, and could not, not even with -9 and could not
> > > even reboot.
> > > 
> > > I went back to v4.1 (ok, quite far, I see), and problems are gone.
> > > 
> > > Does it work for you? Any ideas what to try... besides bisect?
> > 
> > v4.7 is okay.
> > 
> > v4.8 with
> > 
> > git diff ..mini-v4.7 drivers/hsi/ | git apply
> > 
> > Seems to work ok.

Hmm. I guess I made some error with the testing, because reverting
just drivers/hsi to v4.7 state results in non-compiling kernel

> hsi changes from 4.7 to 4.8 are basically runtime PM enablement.
> Does 4.8 work for you with just 9c99e5e51988 reverted?

No, according to the notes. But see above... and let me retry with
drivers/hsi _and_ include/linux/hsi reverted. No GSM audio and same
problem with shutdown. Oops. Sorry about the confusion.

Does it work for you? Any ideas what could be wrong?

Best regards,

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
