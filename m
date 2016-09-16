From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 16 Sep 2016 10:30:53 +0200
Subject: v4.8-rc: GSM audio causes trouble
In-Reply-To: <20160915205142.GA6747@amd>
References: <20160915121755.GA5264@amd>
 <20160915205142.GA6747@amd>
Message-ID: <20160916083053.GA9252@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2016-09-15 22:51:42, Pavel Machek wrote:
> Hi!
> 
> > I was trying to improve GSM call quality, and hit problems in
> > v4.8-rc. Sound only worked for a while, then I tried to kill
> > cmtspeech_ofono_test, and could not, not even with -9 and could not
> > even reboot.
> > 
> > I went back to v4.1 (ok, quite far, I see), and problems are gone.
> > 
> > Does it work for you? Any ideas what to try... besides bisect?
> 
> v4.7 is okay.
> 
> v4.8 with
> 
> git diff ..mini-v4.7 drivers/hsi/ | git apply

I believe I tried just reverting
9c99e5e51988798af2a687ef9b1716dd79388550 before, but that did not
help.

I guess I'll try with these reverted, next:

pavel at amd:/data/l/linux-n900$ git show
9c99e5e51988798af2a687ef9b1716dd79388550 | git apply -R
pavel at amd:/data/l/linux-n900$ git show
ad60db2f9fe3367e60a21fc0afe19999516f8b27 | git apply -R
pavel at amd:/data/l/linux-n900$ git show
4e552310cdf0c81210b5fc9173f7cf497eeb9feb | git apply -R
pavel at amd:/data/l/linux-n900$ git show
604fdfa45886f04ad6070c1b8266c7f4154bc497 | git apply -R
pavel at amd:/data/l/linux-n900$ git show
d2b8d695c61c4d2864eee900bebc2ced4f425645 | git apply -R
pavel at amd:/data/l/linux-n900$ git show
fa1572d956ee072e965da01d2c46f10d2b67d017 | git apply -R
pavel at amd:/data/l/linux-n900$ git show
62aa292b3eae920a80c2fd0ed0601a70328627f6 | git apply -R
pavel at amd:/data/l/linux-n900$

...seems to be broken already. I guess its time to
bisect... hmm. Tried bisecting, but soundcard does not work
there. Will do it manually...

Best regards,
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
