From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 27 Jan 2015 14:21:27 +0100
Subject: [PATCH] ARM: /proc/atags: Export also for DT
In-Reply-To: <CAL_JsqL_EEg7tC-q8wV5v8jAfPSiri4z19iJfz2r7zntRwPyOg@mail.gmail.com>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
 <201412041857.49341@pali>
 <CAL_JsqJ9i0jwaL1cyeomQG=bhhcnEgdGWYOqkcwidyk5xOUukg@mail.gmail.com>
 <201501262016.52079@pali>
 <CAL_JsqL_EEg7tC-q8wV5v8jAfPSiri4z19iJfz2r7zntRwPyOg@mail.gmail.com>
Message-ID: <20150127132127.GA869@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2015-01-26 14:33:21, Rob Herring wrote:
> On Mon, Jan 26, 2015 at 1:16 PM, Pali Roh?r <pali.rohar@gmail.com> wrote:
> > This patch will cause that decompressor store full ATAG structure into DT tree ("/atags"):
> >

> > +       /* include the terminating ATAG_NONE */
> > +       atag_size = (char *)atag - (char *)atag_list + sizeof(struct tag_header);
> > +       setprop(fdt, "/", "atags", atag_list, atag_size);
> > +
> >         if (memcount) {
> >                 setprop(fdt, "/memory", "reg", mem_reg_property,
> >                         4 * memcount * memsize);
> >
> >
> >
> > And this patch will export ATAG structure from DT tree ("/atags") into /proc/atags file:
> 
> Please properly send your patches.

Actually, when sending patches for discussion, this is format easier
to read.

> > Some userspace applications needs access to ATAG structure where can be stored some information passed
> > from bootloader to kernel. Example is Nokia N900 device and NOLO bootloader which provides information
> > about bootreason (device was started by power button or by alarm or restarted...) and bootmode (normal
> > mode or device update mode).
> 
> This goes in the commit message.
> 
> These would be non-standard fields which are not upstream. I don't
> know that we care in that case...

Other devices are going to care about boot reason, too, and we might
as well be compatible...
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
