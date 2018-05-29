From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 29 May 2018 22:45:17 +0200
Subject: v4.17-rc1: regressions on N900, N950
In-Reply-To: <20180524094705.GA16705@amd>
References: <20180423202940.ig6iud5lrbgnu35a@darkstar.musicnaut.iki.fi>
 <20180521213952.GA11596@amd> <20180522080250.4fzyvqrgw5oigexn@pali>
 <20180522194139.GB2299@darkstar.musicnaut.iki.fi>
 <20180522205824.GA24927@amd>
 <20180522215638.GC2299@darkstar.musicnaut.iki.fi>
 <20180523140615.GA27180@amd> <20180523201208.GA31731@amd>
 <20180523220456.GY98604@atomide.com> <20180524094705.GA16705@amd>
Message-ID: <20180529204517.GA6765@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > still results in working touchscreen, removing any of the three fields
> > > breaks it again.
> > 
> > I bisected one regression down, see "omapdrm regression in v4.17-rc series"
> > not sure if it covers all the issues being discussed here though.
> 
> Reverting 24aac6011f70 fixes screen on n900 in v4.17-rc for me. (But
> strange dependency on tsc2005 at 0 is still there).

Laurent, your patch looks pretty obvious, but unfortunately breaks
display on Nokia N900.

The patch is pretty big as is, perhaps you have version split to sdi
=> *sdi and then static => dynamic allocation?

Thanks,
								Pavel

commit 24aac6011f704d69b5f34514923413f85669f282
Author: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date:   Tue Feb 13 14:00:47 2018 +0200

    drm: omapdrm: sdi: Allocate the sdi private data structure
    dynamically

    The sdi private data structure is currently stored as a global
        variable. While no platform with multiple SDI encoders
        currently exists
	    nor is planned, this doesn't comply with the kernel device
        model and
	    should thus be fixed.
    


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180529/4beb1f9c/attachment.sig>
