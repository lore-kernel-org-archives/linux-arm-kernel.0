From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 13 Apr 2018 10:39:48 +0200
Subject: [PATCH v2 2/2] dmaengine: stm32-mdma: Fix incomplete Hw
 descriptors allocator
In-Reply-To: <20180413040233.GJ6014@localhost>
References: <1523457879-9869-1-git-send-email-pierre-yves.mordret@st.com>
 <1523457879-9869-3-git-send-email-pierre-yves.mordret@st.com>
 <20180413040233.GJ6014@localhost>
Message-ID: <CAMuHMdWNyvveQ73SDrVy=EwkkO6Gd_4hmOkdstpcgzOL44a_mA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On Fri, Apr 13, 2018 at 6:02 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Wed, Apr 11, 2018 at 04:44:39PM +0200, Pierre-Yves MORDRET wrote:
>
>>  struct stm32_mdma_desc {
>>       struct virt_dma_desc vdesc;
>>       u32 ccr;
>> -     struct stm32_mdma_hwdesc *hwdesc;
>> -     dma_addr_t hwdesc_phys;
>>       bool cyclic;
>>       u32 count;
>> +     struct stm32_mdma_desc_node node[];
>
> some ppl use node[0] for this but i think either is fine..

node[] is the correct one, node[0] may hide future bugs, cfr. commit
a158531f3c92467d ("gpio: 74x164: Fix crash during .remove()")

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
