From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 13 May 2010 03:02:36 +0100
Subject: [PATCH 11/11] ARM: S5P6440: Remove redundant defines
In-Reply-To: <AANLkTimTm_Vxvb2xvJnVxTxUaYguFgGeaWGypzA1yjwM@mail.gmail.com>
References: <1273710481-14856-1-git-send-email-kgene.kim@samsung.com>
	<AANLkTimTm_Vxvb2xvJnVxTxUaYguFgGeaWGypzA1yjwM@mail.gmail.com>
Message-ID: <20100513020236.GS6684@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 13, 2010 at 10:49:29AM +0900, Jassi Brar wrote:
> On Thu, May 13, 2010 at 9:28 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > From: Thomas Abraham <thomas.ab@samsung.com>
> > --- a/arch/arm/mach-s5p6440/clock.c
> > +++ b/arch/arm/mach-s5p6440/clock.c
> > @@ -357,121 +357,121 @@ static struct clk init_clocks_disable[] = {
> > ? ? ? ? ? ? ? ?.id ? ? ? ? ? ? = -1,
> > ? ? ? ? ? ? ? ?.parent ? ? ? ? = &clk_hclk.clk,
> > ? ? ? ? ? ? ? ?.enable ? ? ? ? = s5p6440_mem_ctrl,
> > - ? ? ? ? ? ? ? .ctrlbit ? ? ? ?= S5P_CLKCON_MEM0_HCLK_NFCON,
> > + ? ? ? ? ? ? ? .ctrlbit ? ? ? ?= (1 << 2),
> Peculiar. I have never seen defines dropped in favor of magic numbers.

I know it seems a little odd at first, but people seem to be clinging
on to writing it down in a header file and then using it once as some
form of high law of programming. Whilst talking with Kukjin and others
last year and looking at this, we came to the following conclusions
about single-use defines:

1) It takes two lines of code, where one is sufficient.

2) You only have to look in the relevant .c file to find out the
   value instead of tracking down a header. This makes it easier
   to verify the value against the manual and easier to compare
   against simialr code.

Thus ends today's public service broadcast.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
