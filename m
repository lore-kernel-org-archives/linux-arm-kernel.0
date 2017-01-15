From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Sun, 15 Jan 2017 01:00:54 +0100
Subject: Nokia N900: mixers changed between 4.9 and 4.10-rc3,
 no longer can use in-call speaker
In-Reply-To: <20170114225614.GA25321@amd>
References: <20170112181826.GA28290@amd> <201701121934.19810@pali>
 <20170114225614.GA25321@amd>
Message-ID: <201701150100.54214@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 14 January 2017 23:56:15 Pavel Machek wrote:
> Hi!
> 
> > > In v4.10 (and probably v4.9, too) I can no longer use the in-call
> > > speaker. I can no longer use the wired headset, either.
> > > 
> > > v4.4 (and probably v4.6) works ok.
> > > 
> > > Any ideas? Does wired headset / in-call speaker work for you?
> > > 
> > > "Mono" and "Mono DAC" options are still there.. but something
> > > else changed, as alsamixer now shows way many more options
> > > (meaning they are shorter?) and I get complains from alsactl:
> > > 
> > > alsactl: set_control:1328: failed to obtain info for control #49
> > > (No such file or directory)
> > > ...
> > > alsactl: set_control:1328: failed to obtain info for control #229
> > > (No such file or directory)
> > 
> > Looks like there are not so much commits related to
> > sound/soc/omap/rx51.c Maybe it can be one of these twos?
> > 
> > cb7e62256e99d285e415cf75db67558f0f8bb107
> > 6d2de5ab4328718302c54b20222c6b1a574c3fce
> 
> Both are based on v4.7-rc1. v4.6 worked ok for me.
> 
> Lets test mini-v4.7: in-call speaker works ok there, and no alsactl
> warnings.
> 
> mini-v4.7+cb7e62256e99d285e415cf75db67558f0f8bb107+6d2de5ab4328718302
> c54b20222c6b1a574c3fce
> 
> : something seems to be broken there already.
> 
> alsactl: set_control:1464: Cannot write control '2:0:0:TPA6130A2
> Headphone Playback Volume:0' : Remote I/O error
> 
> But in-call speakers and wired headset still seems to work.
> 
> Lets test mini-v4.9... works ok. I don't even get the remote i/o
> error. Interesting.
> 
> So regression seems to be between v4.9 and v4.10. Any ideas?

Interesting... seems there are no sound relevant changes after v4.9.

Looks like there are only three commits after v4.9 for sound/soc which 
are built for Nokia N900:

e411b0b5eb9b65257a050eac333d181d6e00e2c6
e7aa450fe17890e59db7d3c2d8eff5b6b41fc531
63c3194b82530bd71fd49db84eb7ab656b8d404a

Maybe something not related to sound/soc could broke it?

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170115/1ff353d6/attachment.sig>
