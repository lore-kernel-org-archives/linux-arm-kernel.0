From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 14 Nov 2017 15:39:41 +0100
Subject: [PATCH 1/2] arm64: dts: orange-pi-zero-plus2: fix sdcard detect
In-Reply-To: <20171113192411.kmohcthzickk4n5v@speedy.hunter>
References: <20171103195855.15283-2-geomatsi@gmail.com>
 <CAMty3ZCs8kq1vUGLOi0ZghY7n0iXgUQ1E=ngBO6Y4wm7wMLF7Q@mail.gmail.com>
 <20171104154221.ao7kkcwqhnja3cxe@speedy.hunter>
 <20171106122633.5mnqfh6xhmmxr45s@flea>
 <20171106161306.tq6yeq6bq36ridj3@speedy.hunter>
 <CAMty3ZCYQx0MfiJnOZPtO4nSAtOrGicOzw_x_AznTiEW8h2sLg@mail.gmail.com>
 <CAMty3ZANhL7cHqYw4VY2Sj_JUZGyqFZ+7pLssc1tniN3BdupOA@mail.gmail.com>
 <20171107201245.gptgfli54o6eqmrj@speedy.hunter>
 <CAMty3ZB3aXCsd9VkibjxPdA=BXvXr3nMbGJJvtZN_z2SGVUAXA@mail.gmail.com>
 <20171113192411.kmohcthzickk4n5v@speedy.hunter>
Message-ID: <20171114143941.3qgdlqn4xfarfhql@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergey,

On Mon, Nov 13, 2017 at 10:24:11PM +0300, Sergey Matyukevich wrote:
> Hello Maxime,
> 
> On Wed, Nov 08, 2017 at 04:55:32PM +0530, Jagan Teki wrote:
> > On Wed, Nov 8, 2017 at 1:42 AM, Sergey Matyukevich <geomatsi@gmail.com> wrote:
> > > Hi,
> > >
> > >> >>> > Did you try to boot from sdcard ? I am not able to boot my board from
> > >> >>> > sd-card without this change. As I mentioned earlier in my email
> > >> >>> > to buildroot mailing list, with mmc debug enabled I see that mmc
> > >> >>> > tries to init sd-card when I remove it from the slot.
> > >> >>> >
> > >> >>> > Maybe there is a minor differences between h/w versions or batches ?
> > >> >>> > What is you board version ? I tested on board v1.0.
> > >> >>>
> > >> >>> Looking at the schematics, it definitely looks like it's active low.
> > >> >>
> > >> >> Is it ok to merge it then ? Or using 'cd-inverted' property
> > >> >> is the preferable option ?
> > >> >
> > >> > W/o any change mainline works unstable for me, it wasn't booting
> > >> > at-all[1] did you find the same?
> > >> >
> > >> > Even tried with active LOW and cd-inverted.
> > >> >
> > >> > [1] https://paste.ubuntu.com/25909064/
> > >>
> > >> Look like something broken for H5 and A64 between v4.14-rc8 to latest
> > >
> > > Both 4.13.7 and 4.14-rc8 (synched today) kernels worked fine for me.
> > > DTS behavior is all the same:
> > 
> > I've tried fresh sync [2] but still see the issue, can you check the
> > Image size of log(suspecting on that area)
> 
> Do you plan to accept this patch as well ? Or you would prefer to wait
> for the confirmation from Jagan as well ?

I'm happy with the patch, but I was under the impression that the
discussion had not settled yet. If it did, then yeah I'll merge it :)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171114/ff77368e/attachment.sig>
