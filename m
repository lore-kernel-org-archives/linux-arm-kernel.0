From: sebastian.reichel@collabora.co.uk (Sebastian Reichel)
Date: Tue, 29 May 2018 23:09:09 +0200
Subject: v4.17-rc1: regressions on N900, N950
In-Reply-To: <20180529204517.GA6765@amd>
References: <20180521213952.GA11596@amd> <20180522080250.4fzyvqrgw5oigexn@pali>
 <20180522194139.GB2299@darkstar.musicnaut.iki.fi>
 <20180522205824.GA24927@amd>
 <20180522215638.GC2299@darkstar.musicnaut.iki.fi>
 <20180523140615.GA27180@amd> <20180523201208.GA31731@amd>
 <20180523220456.GY98604@atomide.com> <20180524094705.GA16705@amd>
 <20180529204517.GA6765@amd>
Message-ID: <20180529210909.7m4cyhh524xqipju@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

On Tue, May 29, 2018 at 10:45:17PM +0200, Pavel Machek wrote:
> > > > still results in working touchscreen, removing any of the three fields
> > > > breaks it again.
> > > 
> > > I bisected one regression down, see "omapdrm regression in v4.17-rc series"
> > > not sure if it covers all the issues being discussed here though.
> > 
> > Reverting 24aac6011f70 fixes screen on n900 in v4.17-rc for me. (But
> > strange dependency on tsc2005 at 0 is still there).
> 
> Laurent, your patch looks pretty obvious, but unfortunately breaks
> display on Nokia N900.
> 
> The patch is pretty big as is, perhaps you have version split to sdi
> => *sdi and then static => dynamic allocation?

There is a queued fix:

https://github.com/freedesktop/drm-misc/commit/2bc5ff0bdc00d81d719dad74589317a260d583ed

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180529/77c08194/attachment.sig>
