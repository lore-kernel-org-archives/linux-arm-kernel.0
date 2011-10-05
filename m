From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 05 Oct 2011 10:17:16 +0900
Subject: [PATCH V2 2/2] ARM: SAMSUNG: Cleanup resources by using macro
In-Reply-To: <CAH9JG2UR+QY=Ni7BTThgUBf2iBUKX9cdkbq_XRia4aQXDwEeSg@mail.gmail.com>
References: <005901cc817e$51a56d00$f4f04700$%kim@samsung.com>
	<1957187.UuLfeIqa6D@wuerfel>
	<019301cc8293$79a6f510$6cf4df30$%kim@samsung.com>
	<201110041726.03056.arnd@arndb.de>
	<CAH9JG2UR+QY=Ni7BTThgUBf2iBUKX9cdkbq_XRia4aQXDwEeSg@mail.gmail.com>
Message-ID: <01f101cc82fc$85a4a0b0$90ede210$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> On Wed, Oct 5, 2011 at 12:26 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 04 October 2011, Kukjin Kim wrote:
> >> > I think the string concatenation really just obfuscates the code, and
> >> > it does not actually save much at all. When you replace
> >> >
> >> > + ? ? ? [0] = SAMSUNG_RES_MEM(S3C, WDT, SZ_1K),
> >> > + ? ? ? [1] = SAMSUNG_RES_IRQ(WDT),
> >> >
> >> > with
> >> >
> >> > + ? ? ? [0] = DEFINE_RES_MEM(S3C_PA_WDT, SZ_1K),
> >> > + ? ? ? [1] = DEFINE_RES_IRQ(IRQ_WDT),
> >> >
> >> > you need practically no extra space, but you gain the advantages that
> >> >
> >> > * Someone using grep for DEFINE_RES_MEM finds all memory resources
> without
> >> > ? having to look up what your macros do an where they are used.
> >> > * Someone using grep to look for S3C_PA_WDT finds the place where it
is
> >> used.
> >> > * Someone reading the resource definition immediately knows what the
> >> > ? macro does if familiar with other platforms using that macro.
> >>
> >> Yes, right. But I'm preparing to reduce the 'soc' part to consolidate
some
> >> duplicated resources and platform data after this and the new
SAMSUNG_RES
> >> macro will be used.
> There are tools for source browsing e.g., ctags, cscope, grep, git
> grep and so on.
> If you create new SAMSUNG_RES, these tools can't find macro and
> symbols properly.
> 
> Please use the existing macros for own purpose.
> 
OK, it makes sense to me.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> Thank you,
> Kyungmin Park
> >
> > Hmm, can't you instead change the names of these constants to be
> > always the same? That would let you use the regular DEFINE_RES_*
> > definitions without having to introduce your own.
