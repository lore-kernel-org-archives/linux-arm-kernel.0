From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 16 Sep 2009 02:07:53 +0100
Subject: [PATCH 01/10] S3C64XX I2S: S3C64XX_PA_IISV4 defined
In-Reply-To: <1b68c6790909151750q3b2ca864k944d567d76f0eb4c@mail.gmail.com>
References: <1253008953-10441-1-git-send-email-jassi.brar@samsung.com>
	<20090916000925.GB24720@trinity.fluff.org>
	<1b68c6790909151750q3b2ca864k944d567d76f0eb4c@mail.gmail.com>
Message-ID: <20090916010753.GK24720@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2009 at 09:50:59AM +0900, jassi brar wrote:
> On Wed, Sep 16, 2009 at 9:09 AM, Ben Dooks <ben-linux@fluff.org> wrote:
> > On Tue, Sep 15, 2009 at 07:02:33PM +0900, Jassi wrote:
> >> Defined the missing S3C64XX_PA_IISV4 conditionally for 6410 as
> >> it's not avaialble for 6400
> >>
> >> Signed-Off-by: Jassi <jassi.brar@samsung.com>
> >> ---
> >> ?arch/arm/mach-s3c6400/include/mach/map.h | ? ?3 +++
> >> ?1 files changed, 3 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-s3c6400/include/mach/map.h b/arch/arm/mach-s3c6400/include/mach/map.h
> >> index 5057d99..775577a 100644
> >> --- a/arch/arm/mach-s3c6400/include/mach/map.h
> >> +++ b/arch/arm/mach-s3c6400/include/mach/map.h
> >> @@ -44,6 +44,9 @@
> >> ?#define S3C64XX_PA_SYSCON ? ?(0x7E00F000)
> >> ?#define S3C64XX_PA_IIS0 ? ? ? ? ? ? ?(0x7F002000)
> >> ?#define S3C64XX_PA_IIS1 ? ? ? ? ? ? ?(0x7F003000)
> >> +#ifdef CONFIG_CPU_S3C6410
> >> +#define S3C64XX_PA_IISV4 ? ? (0x7F00D000)
> >> +#endif
> >
> > Does this really need to be #ifdef'd out? You might want to avoid
> > building the device setup code, or similar if it is only for a s3c6400
> > but this should be done by the machine Kconfig chosing to build the
> > support in for the machines that do need it.
> >
> > I see no good reason for this to be applied.
> In my second post in this thread, i already said the ifdef had better
> be dropped.
> So, you want me to resend patch without the ifdef?

Yes. remove #ifdef.
 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
