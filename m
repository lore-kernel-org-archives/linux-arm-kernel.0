From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 02 Sep 2010 17:02:30 +0900
Subject: [PATCH 11/13] ARM: S5P64X0: Move SMDK6440 board file and Add
	SMDK6450 board file
In-Reply-To: <AANLkTikXD9xz+mGz1QabwB91WdRX1oPeeOwa-juGdt6H@mail.gmail.com>
References: <1283324960-21629-1-git-send-email-kgene.kim@samsung.com>
	<1283324960-21629-12-git-send-email-kgene.kim@samsung.com>
	<AANLkTikXD9xz+mGz1QabwB91WdRX1oPeeOwa-juGdt6H@mail.gmail.com>
Message-ID: <004901cb4a75$33f2cb90$9bd862b0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> On Wed, Sep 1, 2010 at 4:09 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > This patch moves smdk6440 board file from mach-s5p6440 into the new
> > mach-s5p64x0 directory and adds smdk6450 board file.
> >
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > ---
> > ?.../{mach-s5p6440 => mach-s5p64x0}/mach-smdk6440.c | ? 87 ++++++----
> > ?arch/arm/mach-s5p64x0/mach-smdk6450.c ? ? ? ? ? ? ?| ?182
> ++++++++++++++++++++
> > ?2 files changed, 234 insertions(+), 35 deletions(-)
> > ?rename arch/arm/{mach-s5p6440 => mach-s5p64x0}/mach-smdk6440.c (66%)
> > ?create mode 100644 arch/arm/mach-s5p64x0/mach-smdk6450.c
> >
> > diff --git a/arch/arm/mach-s5p6440/mach-smdk6440.c b/arch/arm/mach-
> s5p64x0/mach-smdk6440.c
> > similarity index 66%
> > rename from arch/arm/mach-s5p6440/mach-smdk6440.c
> > rename to arch/arm/mach-s5p64x0/mach-smdk6440.c
> > index 9202aaa..28de0a5 100644
> > --- a/arch/arm/mach-s5p6440/mach-smdk6440.c
> > +++ b/arch/arm/mach-s5p64x0/mach-smdk6440.c

(snip)

> > @@ -58,43 +59,60 @@
> >
> > ?static struct s3c2410_uartcfg smdk6440_uartcfgs[] __initdata = {
> > ? ? ? ?[0] = {
> > - ? ? ? ? ? ? ? .hwport ? ? ?= 0,
> > - ? ? ? ? ? ? ? .flags ? ? ? = 0,
> > - ? ? ? ? ? ? ? .ucon ? ? ? ?= SMDK6440_UCON_DEFAULT,
> > - ? ? ? ? ? ? ? .ulcon ? ? ? = SMDK6440_ULCON_DEFAULT,
> > - ? ? ? ? ? ? ? .ufcon ? ? ? = SMDK6440_UFCON_DEFAULT,
> > + ? ? ? ? ? ? ? .hwport ? ? ? ? = 0,
> > + ? ? ? ? ? ? ? .flags ? ? ? ? ?= 0,
> There's no place to use this flags, it's posted for long time. but you
> don't listen it.
> I hope delete it if not used.

Will be removed flags member after merging it in the mainline.

> > + ? ? ? ? ? ? ? .ucon ? ? ? ? ? = SMDK6440_UCON_DEFAULT,
> > + ? ? ? ? ? ? ? .ulcon ? ? ? ? ?= SMDK6440_ULCON_DEFAULT,
> > + ? ? ? ? ? ? ? .ufcon ? ? ? ? ?= SMDK6440_UFCON_DEFAULT,
> > ? ? ? ?},

(snip)

> > +
> > +MACHINE_START(SMDK6450, "SMDK6450")
> 
> I think you can make a single SMDK file.

Because the components on the board are different,
SMDK6440 and SMDK6450 need each machine file.

(snip)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
