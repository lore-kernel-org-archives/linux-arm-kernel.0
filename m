From: gregkh@linuxfoundation.org (Greg KH)
Date: Sat, 10 Nov 2018 17:11:05 -0800
Subject: [PATCH for-stable] dmaengine: stm32-dma: fix incomplete
 configuration in cyclic mode
In-Reply-To: <20181017000003.GC140578@joelaf.mtv.corp.google.com>
References: <20181017000003.GC140578@joelaf.mtv.corp.google.com>
Message-ID: <20181111011105.GA18060@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2018 at 05:00:03PM -0700, Joel Fernandes (Google) wrote:
> From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
> 
> commit e57cb3b3f10d005410f09d4598cc6d62b833f2b0 upstream.
> 
> When in cyclic mode, the configuration is updated after having started the
> DMA hardware (STM32_DMA_SCR_EN) leading to incomplete configuration of
> SMxAR registers.
> 
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> ---
>  drivers/dma/stm32-dma.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

I'm just guessing you want this for 4.14.y?  I've added it there.  If
not, please give me a hint :)
