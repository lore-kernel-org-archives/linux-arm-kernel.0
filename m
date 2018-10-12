From: robh@kernel.org (Rob Herring)
Date: Fri, 12 Oct 2018 09:42:04 -0500
Subject: [PATCH v3 1/7] dt-bindings: stm32-dma: Add DMA/MDMA chaining
 support bindings
In-Reply-To: <1538139715-24406-2-git-send-email-pierre-yves.mordret@st.com>
References: <1538139715-24406-1-git-send-email-pierre-yves.mordret@st.com>
 <1538139715-24406-2-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <20181012144204.GA13615@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2018 at 03:01:49PM +0200, Pierre-Yves MORDRET wrote:
> From: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> 
> This patch adds dma bindings to support DMA/MDMA chaining transfer.
> 1 bit is to manage both DMA FIFO Threshold
> 1 bit is to manage DMA/MDMA Chaining features.
> 2 bits are used to specify SDRAM size to use for DMA/MDMA chaining.
> The size in bytes of a certain order is given by the formula:
>     (2 ^ order) * PAGE_SIZE.
> The order is given by those 2 bits.
> For cyclic, whether chaining is chosen, any value above 1 can be set :
> SRAM buffer size will rely on period size and not on this DT value.
> 
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

Missing author S-o-b.

> ---
>   Version history:
>     v3:
>     v2:
>        * rework content
>     v1:
>        * Initial
> ---
> ---
>  .../devicetree/bindings/dma/stm32-dma.txt          | 27 +++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
