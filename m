From: viresh.kumar@linaro.org (viresh kumar)
Date: Thu, 11 Oct 2012 08:46:04 +0530
Subject: [PATCH 07/11] fsmc/nand: Provide contiguous buffers to dma
In-Reply-To: <CACRpkdb6ArMUQ6MAsue+Gh15UfOUrWNAc9wrxd6awc0BTwOGiw@mail.gmail.com>
References: <cover.1349778820.git.vipin.kumar@st.com>
 <2b88c853b3691338fae037f569917fc300cd6032.1349778821.git.vipin.kumar@st.com>
 <CACRpkdb6ArMUQ6MAsue+Gh15UfOUrWNAc9wrxd6awc0BTwOGiw@mail.gmail.com>
Message-ID: <CAOh2x==Up=mOc+YA6-yKD7xpoxFyzfb-XtoQ6DENTXayTa=vtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 10, 2012 at 10:37 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> The real problem is likely the DMA driver. The stuf that get
> fed into dma.device_prep_dma_memcpy() needs to be
> converted to a scatterlist and then set up in the LLI list
> for the controller.
>
> IIRC SPEAr is using drivers/dma/dw_dmac.c so

Both dw_dmac and pl080 for different SPEAr SoC's.

> check this driver's dwc_prep_dma_memcpy().
> It does seem like it is checking whether src or
> dest is scattered in this for() loop:
>
> for (offset = 0; offset < len; offset += xfer_count << src_width) {}
>
> dma_sync_single_for_device() is translating the virtual
> address to physical for every chunk BTW.
>
> So instead of doing this copying, debug the problem, and
> see if there is a bug in that for()-loop or similar, if it needs
> to be rewritten or so.

But what's the problem you saw vipin, for which you generated this patch?
