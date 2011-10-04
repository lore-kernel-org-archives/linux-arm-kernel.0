From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 04 Oct 2011 21:45:23 +0900
Subject: [PATCH V2 2/2] ARM: SAMSUNG: Cleanup resources by using macro
In-Reply-To: <4E89C4B2.605@samsung.com>
References: <005901cc817e$51a56d00$f4f04700$%kim@samsung.com>
	<CAH9JG2Wc4M2dVFOfNE5jgsygvigE8RbPH_yLcMqarr64LfbENw@mail.gmail.com>
	<4E89B505.3060501@samsung.com> <4E89C4B2.605@samsung.com>
Message-ID: <019401cc8293$7c17a6f0$7446f4d0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sylwester Nawrocki wrote:
> 
> On 10/03/2011 03:13 PM, Kukjin Kim wrote:
> > On 10/03/11 12:53, Kyungmin Park wrote:
> >> On Mon, Oct 3, 2011 at 12:41 PM, Kukjin Kim<kgene.kim@samsung.com>
> wrote:
> >>>
> >>> +#define SAMSUNG_RES_MEM(soc, ip, sz)
> DEFINE_RES_MEM(soc##_PA_##ip, sz)
> >>> +#define SAMSUNG_RES_IRQ(ip)            DEFINE_RES_IRQ(IRQ_##ip)
> >>> +
> >>> +#define SAMSUNG_RES_MEM_NAMED(soc, ip, sz, name)       \
> >>> +
> DEFINE_RES_MEM_NAMED(soc##_PA_##ip, sz, name)
> >>> +#define SAMSUNG_RES_IRQ_NAMED(ip, name)
> \
> >>> +                               DEFINE_RES_IRQ_NAMED(IRQ_##ip,
> name)
> >>> +#define SAMSUNG_RES_DMA_NAMED(ch, name)
> \
> >>> +
> DEFINE_RES_DMA_NAMED(DMACH_##ch, name)
> >>
> >> It's good for readability. but do you think that it's hard to find out
> >> defined macros are used at real place?
> >> e.g., Now I want to find out the S3C_PA_USB_HSOTG. it's difficult if
> >> you use the SAMSUNG_RES_* series macro.
> >> but if you use the DEFINED_RES_* series directly. it's easy to find
> >> out at real codes.
> >>
> > Well, I don't think so because the XXX_PA_XXX addresses are defined in
each
> > mach/map.h and they are usually used in here so it's not hard to find
it.
> 
> Some minor disadvantage is that tagging tools like e.g. gtags don't handle
> these things properly. But I don't think it's really important.
> 
> >
> > And now the 'S3C', 'S5P' and 'SAMSUNG' are used in the 'soc' part. I'm
> > preparing to consolidate the name and to remove duplicated resources.
> 
> Do you also have any specific plans for supporting single image build for
> multiple SoC's while working on this ?

Hmm, you could see through my plan :)
As you know, we need to sort out resources and platform data to support
single kernel image so I'm preparing it after this.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
