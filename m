From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 13 Apr 2018 15:39:22 +0530
Subject: [PATCH v2 2/2] dmaengine: stm32-mdma: Fix incomplete Hw
 descriptors allocator
In-Reply-To: <CAMuHMdWNyvveQ73SDrVy=EwkkO6Gd_4hmOkdstpcgzOL44a_mA@mail.gmail.com>
References: <1523457879-9869-1-git-send-email-pierre-yves.mordret@st.com>
 <1523457879-9869-3-git-send-email-pierre-yves.mordret@st.com>
 <20180413040233.GJ6014@localhost>
 <CAMuHMdWNyvveQ73SDrVy=EwkkO6Gd_4hmOkdstpcgzOL44a_mA@mail.gmail.com>
Message-ID: <20180413100921.GM6014@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 13, 2018 at 10:39:48AM +0200, Geert Uytterhoeven wrote:
> Hi Vinod,
> 
> On Fri, Apr 13, 2018 at 6:02 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> > On Wed, Apr 11, 2018 at 04:44:39PM +0200, Pierre-Yves MORDRET wrote:
> >
> >>  struct stm32_mdma_desc {
> >>       struct virt_dma_desc vdesc;
> >>       u32 ccr;
> >> -     struct stm32_mdma_hwdesc *hwdesc;
> >> -     dma_addr_t hwdesc_phys;
> >>       bool cyclic;
> >>       u32 count;
> >> +     struct stm32_mdma_desc_node node[];
> >
> > some ppl use node[0] for this but i think either is fine..
> 
> node[] is the correct one, node[0] may hide future bugs, cfr. commit
> a158531f3c92467d ("gpio: 74x164: Fix crash during .remove()")

Yeah but it this case it is the last element. But yes it helps to avoid such
mistakes in future..

-- 
~Vinod
