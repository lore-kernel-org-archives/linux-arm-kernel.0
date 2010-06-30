From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 30 Jun 2010 16:09:04 +0200
Subject: [PATCH 4/4] pxa/spitz: Rework spitz
In-Reply-To: <AANLkTinRkgIg1q8LfRF6jWOoxLNY__xMi3iJjEv1FhWL@mail.gmail.com>
References: <1277388132-5549-1-git-send-email-marek.vasut@gmail.com>
	<201006281729.38591.marek.vasut@gmail.com>
	<AANLkTinRkgIg1q8LfRF6jWOoxLNY__xMi3iJjEv1FhWL@mail.gmail.com>
Message-ID: <201006301609.04907.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne St 30. ?ervna 2010 08:57:57 Eric Miao napsal(a):
> On Mon, Jun 28, 2010 at 11:29 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> > Dne Po 28. ?ervna 2010 14:19:46 Eric Miao napsal(a):
> >> On Mon, Jun 28, 2010 at 8:07 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> >> > Dne Po 28. ?ervna 2010 05:43:12 Eric Miao napsal(a):
> >> >> On Thu, Jun 24, 2010 at 10:02 PM, Marek Vasut <marek.vasut@gmail.com>
> > 
> > wrote:
> >> >> > This huge patch mostly shuffles code. The spitz.c file contained
> >> >> > terrible mess and needed a cleanup, here it is:
> >> >> > 
> >> >> > 1) Made every part modular, components are not built in if not
> >> >> > selected. 2) Removed loads of preprocessor goo, mostly "#ifdef
> >> >> > MACH_AKITA .... #endif" and similar code. The kernel size will grow
> >> >> > by a few kb now, but the file is much more readable.
> >> >> > 3) Reworked SD/CF power setting function and made it reentrant.
> >> >> > 4) Add ISL6271A regulator support
> >> >> > 5) Correctly register WM8750
> >> >> > 
> >> >> > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> >> >> 
> >> >> I'd prefer to see separate small patches for this?
> >> > 
> >> > This is nearly a replacement for the whole file ... maybe we could
> >> > merge spitz2.c or something ... or do it this way. I understand your
> >> > point about spliting it into smaller chunks, but I don't see a reason
> >> > in this case.
> >> 
> >> I guess the above 1, 2, 3, 4, 5 can be well separated into 5 patches,
> >> I don't mind merge many patches, but I'd really like to see small and
> >> consistent changes (make it regression test friendly BTW), ;-)
> > 
> > I said I get your point, but I don't see the benefit here.
> > 1) already does most of the rewrite of the file,
> > 2) only removes the #ifdef MACH_PLAT around MACHINE_START (as the rest
> > was done in 1) ),
> > 3) is actually a part of 1) as well
> > 4) ok, this could be separated out, but I see no benefit
> > 5) well this is already in if I recall well, but I put it here for
> > completeness
> 
> Several of other comments, though:
> 
> 1. It doesn't look necessary to me to change spitz_* to sharpslc_*. spitz_*
>    isn't a good prefix, neither is sharpslc_* (think about the corgi
> series, which is normally called Sharp SL-C7xx). And this is also going to
> save many unnecessary changes.

I know, but what prefix do you sugest then?
> 
> 2. Direct references of spitzscoop[12]_device are still there, which I'd
>    prefer a cleaner patch for this

I'd prefer rewriting the whole scoop driver and patching the pcmcia driver so 
all this crap can get lot.
> 
> 3. Others seem to be coding style changes - which can be separated

You're right.
