From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 28 Aug 2017 15:59:59 +0200
Subject: [PATCH] nokia n900: update dts with camera support
In-Reply-To: <20170817000845.agkcuvqaheejm33j@earth>
References: <20170810204923.GA18442@amd>
 <20170814201950.sbtyuksn3ntuigyp@valkosipuli.retiisi.org.uk>
 <20170815220349.GA15441@amd>
 <20170816205332.rqcuenvuxfs5jvuw@earth>
 <20170816205915.GA5386@atrey.karlin.mff.cuni.cz>
 <20170816212343.hfd4azb4dq2qrlkc@valkosipuli.retiisi.org.uk>
 <20170817000845.agkcuvqaheejm33j@earth>
Message-ID: <20170828135959.GA32560@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > Well, strobe property above already uses = <0>/<1> format, as do
> > > others.
> >
> > > Problem with "false = property does not exist" is that you don't know
> > > if it is "someone forgot to define it" or "someone made a typo" or
> > > "dts is too old to know about this property" or "the property indeed
> > > should be false"...
> >
> > As this is an established practice, I think we should follow it for bool
> > properties.
> 
> Yes it's common practice, there is also device_property_read_bool()
> to get the value.
> 
> > We could change the existing ones, too, and leave some extra checks in
> > place to handle old dtbs.
> 
> The following should be downward compatible:
> 
> var = read_bool();
> if (var && !read_int())
>     var = false;
> 
> Btw. DT people should be CC'd for DT binding additions/changes.

Ok, so for now we do crc=1 by default. Now we'd like to have crc
support configurable in the dts. But if we just introduce "crc;"
option, it will break old dts users. We could introduce "no-crc;" and
that would work in this particular case, but will break when we want
different defaults at different devices.

Anyway, introducing "no-crc;" seems pretty ugly to me. I'd rather do
"crc=<0>;", in a similar way we handle other options now.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170828/99e52bf9/attachment.sig>
