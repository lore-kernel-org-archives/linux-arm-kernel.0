From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 24 May 2018 11:47:05 +0200
Subject: v4.17-rc1: regressions on N900, N950
In-Reply-To: <20180523220456.GY98604@atomide.com>
References: <20180422074213.GA12428@amd>
 <20180423202940.ig6iud5lrbgnu35a@darkstar.musicnaut.iki.fi>
 <20180521213952.GA11596@amd> <20180522080250.4fzyvqrgw5oigexn@pali>
 <20180522194139.GB2299@darkstar.musicnaut.iki.fi>
 <20180522205824.GA24927@amd>
 <20180522215638.GC2299@darkstar.musicnaut.iki.fi>
 <20180523140615.GA27180@amd> <20180523201208.GA31731@amd>
 <20180523220456.GY98604@atomide.com>
Message-ID: <20180524094705.GA16705@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > So... I did some experiments on v4.16.
> > > 
> > > Swapping tsc2005 at 0 and lcd: acx565akm at 2 entries in the dts does break
> > > stuff.
> > > 
> > > I thought it might be due to vio regulator, but it does not appear
> > > so... screen still works with tsc2005 driver disabled in .config. (so
> > > there's noone to enable vio regulator).
> > 
> > Deleting tsc2005 at 0 entry also breaks screen.
> > 
> > Replacing tsc2005 at 0 entry with 
> > 
> >         foobar at 0 {
> > 	               compatible = "not really with anything";
> >  		       spi-max-frequency = <6000000>;
> >  		       reg = <0>;
> >  };
> > 
> > still results in working touchscreen, removing any of the three fields
> > breaks it again.
> 
> I bisected one regression down, see "omapdrm regression in v4.17-rc series"
> not sure if it covers all the issues being discussed here though.

Reverting 24aac6011f70 fixes screen on n900 in v4.17-rc for me. (But
strange dependency on tsc2005 at 0 is still there).

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180524/ce0bf288/attachment.sig>
