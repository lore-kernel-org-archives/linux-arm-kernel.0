From: geomatsi@gmail.com (Sergey Matyukevich)
Date: Tue, 14 Nov 2017 21:53:15 +0300
Subject: [PATCH 1/2] arm64: dts: orange-pi-zero-plus2: fix sdcard detect
In-Reply-To: <20171114143941.3qgdlqn4xfarfhql@flea.lan>
References: <CAMty3ZCs8kq1vUGLOi0ZghY7n0iXgUQ1E=ngBO6Y4wm7wMLF7Q@mail.gmail.com>
 <20171104154221.ao7kkcwqhnja3cxe@speedy.hunter>
 <20171106122633.5mnqfh6xhmmxr45s@flea>
 <20171106161306.tq6yeq6bq36ridj3@speedy.hunter>
 <CAMty3ZCYQx0MfiJnOZPtO4nSAtOrGicOzw_x_AznTiEW8h2sLg@mail.gmail.com>
 <CAMty3ZANhL7cHqYw4VY2Sj_JUZGyqFZ+7pLssc1tniN3BdupOA@mail.gmail.com>
 <20171107201245.gptgfli54o6eqmrj@speedy.hunter>
 <CAMty3ZB3aXCsd9VkibjxPdA=BXvXr3nMbGJJvtZN_z2SGVUAXA@mail.gmail.com>
 <20171113192411.kmohcthzickk4n5v@speedy.hunter>
 <20171114143941.3qgdlqn4xfarfhql@flea.lan>
Message-ID: <20171114185315.gwyacchfct4zvyif@speedy.hunter>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Maxime, Jagan,

> > > >> >>> > Did you try to boot from sdcard ? I am not able to boot my board from
> > > >> >>> > sd-card without this change. As I mentioned earlier in my email
> > > >> >>> > to buildroot mailing list, with mmc debug enabled I see that mmc
> > > >> >>> > tries to init sd-card when I remove it from the slot.
> > > >> >>> >
> > > >> >>> > Maybe there is a minor differences between h/w versions or batches ?
> > > >> >>> > What is you board version ? I tested on board v1.0.
> > > >> >>>
> > > >> >>> Looking at the schematics, it definitely looks like it's active low.
> > > >> >>
> > > >> >> Is it ok to merge it then ? Or using 'cd-inverted' property
> > > >> >> is the preferable option ?
> > > >> >
> > > >> > W/o any change mainline works unstable for me, it wasn't booting
> > > >> > at-all[1] did you find the same?
> > > >> >
> > > >> > Even tried with active LOW and cd-inverted.
> > > >> >
> > > >> > [1] https://paste.ubuntu.com/25909064/
> > > >>
> > > >> Look like something broken for H5 and A64 between v4.14-rc8 to latest
> > > >
> > > > Both 4.13.7 and 4.14-rc8 (synched today) kernels worked fine for me.
> > > > DTS behavior is all the same:
> > > 
> > > I've tried fresh sync [2] but still see the issue, can you check the
> > > Image size of log(suspecting on that area)
> > 
> > Do you plan to accept this patch as well ? Or you would prefer to wait
> > for the confirmation from Jagan as well ?
> 
> I'm happy with the patch, but I was under the impression that the
> discussion had not settled yet. If it did, then yeah I'll merge it :)

Both schematics and my tests on v1.0 board confirm that this fix is ok.
However we haven't yet got the ACK from Jagan, the original submitter
of this dts file. FWIW discussion was mostly about the problems with
his setup and not about the fix itself.

Jagan,
did you have a chance to resolve the issues with your setup and verify
that boot from sd-card is fixed by this patch ?

Regards,
Sergey
