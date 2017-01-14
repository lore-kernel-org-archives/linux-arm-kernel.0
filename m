From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 14 Jan 2017 23:56:15 +0100
Subject: Nokia N900: mixers changed between 4.9 and 4.10-rc3, no longer
 can use in-call speaker
In-Reply-To: <201701121934.19810@pali>
References: <20170112181826.GA28290@amd>
 <201701121934.19810@pali>
Message-ID: <20170114225614.GA25321@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > In v4.10 (and probably v4.9, too) I can no longer use the in-call
> > speaker. I can no longer use the wired headset, either.
> > 
> > v4.4 (and probably v4.6) works ok.
> > 
> > Any ideas? Does wired headset / in-call speaker work for you?
> > 
> > "Mono" and "Mono DAC" options are still there.. but something else
> > changed, as alsamixer now shows way many more options (meaning they
> > are shorter?) and I get complains from alsactl:
> > 
> > alsactl: set_control:1328: failed to obtain info for control #49 (No
> > such file or directory)
> > ...
> > alsactl: set_control:1328: failed to obtain info for control #229 (No
> > such file or directory)
> 
> Looks like there are not so much commits related to 
> sound/soc/omap/rx51.c Maybe it can be one of these twos?
> 
> cb7e62256e99d285e415cf75db67558f0f8bb107
> 6d2de5ab4328718302c54b20222c6b1a574c3fce

Both are based on v4.7-rc1. v4.6 worked ok for me.

Lets test mini-v4.7: in-call speaker works ok there, and no alsactl
warnings.

mini-v4.7+cb7e62256e99d285e415cf75db67558f0f8bb107+6d2de5ab4328718302c54b20222c6b1a574c3fce
: something seems to be broken there already.

alsactl: set_control:1464: Cannot write control '2:0:0:TPA6130A2
Headphone Playback Volume:0' : Remote I/O error

But in-call speakers and wired headset still seems to work.

Lets test mini-v4.9... works ok. I don't even get the remote i/o
error. Interesting.

So regression seems to be between v4.9 and v4.10. Any ideas?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170114/3faf5c9e/attachment.sig>
