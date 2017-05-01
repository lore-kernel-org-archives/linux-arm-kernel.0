From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 1 May 2017 11:42:30 +0530
Subject: [PATCH 2/2] dmaengine: Add STM32 MDMA driver
In-Reply-To: <d1d92f79-ce3c-e057-7f47-1fd5e42fa5dc@st.com>
References: <1489417599-31308-1-git-send-email-cedric.madianga@gmail.com>
 <1489417599-31308-3-git-send-email-cedric.madianga@gmail.com>
 <20170406070805.GG4094@localhost>
 <d1d92f79-ce3c-e057-7f47-1fd5e42fa5dc@st.com>
Message-ID: <20170501061230.GP6263@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 26, 2017 at 12:35:46PM +0000, Pierre Yves MORDRET wrote:
> On 04/06/2017 09:08 AM, Vinod Koul wrote:
> >> +static int stm32_mdma_get_width(struct stm32_mdma_chan *chan,
> >> +				enum dma_slave_buswidth width)
> >> +{
> >> +	switch (width) {
> >> +	case DMA_SLAVE_BUSWIDTH_1_BYTE:
> >> +		return STM32_MDMA_BYTE;
> >> +	case DMA_SLAVE_BUSWIDTH_2_BYTES:
> >> +		return STM32_MDMA_HALF_WORD;
> >> +	case DMA_SLAVE_BUSWIDTH_4_BYTES:
> >> +		return STM32_MDMA_WORD;
> >> +	case DMA_SLAVE_BUSWIDTH_8_BYTES:
> >> +		return STM32_MDMA_DOUBLE_WORD;
> >
> > IIUC we can do this with ffs()
> 
> I don't believe we can do that. This function translates DMA_SLAVE enum 
> into internal register representation.

Yes and internal represenation seemed to be ffs() of dmanegine one.

> >> +subsys_initcall(stm32_mdma_init);
> >
> > why subsys?
> >
> 
> subsys_initcall level is to ensure MDMA is going to be probed before its 
> clients

Please use deffered probe approach for that

-- 
~Vinod
