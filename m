From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 13 Oct 2011 14:52:03 -0400 (EDT)
Subject: [PATCH 2/3] ARM: Exynos4: Add ioremap interceptor for statically
	remapped regions
In-Reply-To: <CAJuYYwTpUX+zdRr5PO9SW+nUFW-BwsSwWkWXNRjw_TKy+vdEgw@mail.gmail.com>
References: <1318234289-22041-1-git-send-email-thomas.abraham@linaro.org>
	<1318234289-22041-3-git-send-email-thomas.abraham@linaro.org>
	<4E95BC8E.8010105@gmail.com>
	<CAJuYYwSQgiZMEuzyqFvijy+sTLWqi=TqvM8cGe=W3bPOSBe0Hg@mail.gmail.com>
	<CAJuYYwTpUX+zdRr5PO9SW+nUFW-BwsSwWkWXNRjw_TKy+vdEgw@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1110131448130.17040@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Oct 2011, Thomas Abraham wrote:

> On 12 October 2011 22:00, Thomas Abraham <thomas.abraham@linaro.org> wrote:
> > On 12 October 2011 21:43, Rob Herring <robherring2@gmail.com> wrote:
> >> On 10/10/2011 03:11 AM, Thomas Abraham wrote:
> >>> ioremap() request for statically remapped regions are intercepted and the
> >>> statically assigned virtual address is returned. For requests for which
> >>> there are no statically remapped regions, the requests are let through.
> >>>
> >>> Cc: Kukjin Kim <kgene.kim@samsung.com>
> >>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> >>> ---
> >>> ?arch/arm/mach-exynos4/cpu.c ? ? ? ? ? ? | ? 16 ++++++++++++++++
> >>> ?arch/arm/mach-exynos4/include/mach/io.h | ? ?4 ++++
> >>> ?2 files changed, 20 insertions(+), 0 deletions(-)
> >>>
> >>
> >> You won't need this with Nico's vmalloc.h clean-up series. It does
> >> exactly this but generically for all platforms.
> >
> > Ok. Thanks for your suggestion. I will move to using Nico's patches.
> 
> From Nico's reply to his pull request of vmalloc cleanup series, it
> looks like that pull request has been withdrawn (hope I am not missing
> anything here).

I'm just postponing it because this depends on a large cleanup in the 
OMAP code which is being pushed to mainline for the next merge window.

> Without Nico's series, and gic dt support for exynos4 support 
> requiring this patch, all other workarounds to replace this patch does 
> not seem be correct.
> 
> So is it acceptable to retain this patch and later rework/drop the
> exynos4 specific ioremap along with Nico's vmalloc patch series when
> it is merged.

I would guess so.  But please CC me on those patches so I know what to 
look for when rebasing my series.


Nicolas
