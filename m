From: will.deacon@arm.com (Will Deacon)
Date: Mon, 22 Jul 2013 14:45:15 +0100
Subject: [PATCH] ARM: bugfix: Features of /proc/cpuinfo is wrong
In-Reply-To: <20130718155115.GC9733@mudshark.cambridge.arm.com>
References: <1374043709-24770-1-git-send-email-koba@kmckk.co.jp>
 <20130718155115.GC9733@mudshark.cambridge.arm.com>
Message-ID: <20130722134515.GB30857@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 04:51:15PM +0100, Will Deacon wrote:
> On Wed, Jul 17, 2013 at 07:48:29AM +0100, Tetsuyuki Kobayashi wrote:
> > Array hwcap_str[19] should be "vfpd32" and hwcap_str[20] should be "lpae".
> > But actually "vfpd32" was missing and "lpae" was at wrong place.
> > 
> > Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
> 
> [...]
> 
> > diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> > index 63af9a7..96286cb 100644
> > --- a/arch/arm/kernel/setup.c
> > +++ b/arch/arm/kernel/setup.c
> > @@ -971,6 +971,7 @@ static const char *hwcap_str[] = {
> >  	"vfpv4",
> >  	"idiva",
> >  	"idivt",
> > +	"vfpd32",
> >  	"lpae",
> >  	NULL
> >  };
> > -- 
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Please can you put this into the patch system? It needs to get in for 3.11.

I still can't see this in the patch system. I've tested it on A5, A7, A9 and
A15 and it works as expected.

Will
