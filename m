From: robh@kernel.org (Rob Herring)
Date: Wed, 11 May 2016 09:34:22 -0500
Subject: [PATCH v5 1/4] ASoC: davinci-mcbsp: add binding for McBSP
In-Reply-To: <1462804522-29544-2-git-send-email-petr@barix.com>
References: <1462804522-29544-1-git-send-email-petr@barix.com>
 <1462804522-29544-2-git-send-email-petr@barix.com>
Message-ID: <20160511143422.GA21634@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 09, 2016 at 04:35:19PM +0200, Petr Kulhavy wrote:
> Add devicetree binding for the TI DA850/OMAP-L138/AM18xx
> MultiChannel Buffered Serial Port (McBSP)
> 
> The optional register range "dat" is not implemented at the moment.
> The current driver supports only DMA into RX/TX registers but no FIFO.
> Once the FIFO is implemented in the driver the "dat" range will be used.
> 
> Signed-off-by: Petr Kulhavy <petr@barix.com>
> ---
> v1: initial
> v2: add missing TC channel in dmas properties (for compatibility with the new EDMA3 binding)
>     remove "-audio" postfix from the compatible string
>     remove "channel-combine" property
> v3: remove the index note from the "mpu" property.
>     specify exactly the supported platforms in compatible string
> v4: minor correction in the example ("interrupt names"), re-added index note to the "mpu" property.
> v5: example updated to match da850.dtsi: using "sound@" and removed leading zeros from the reg property
> 
>  .../devicetree/bindings/sound/davinci-mcbsp.txt    | 52 ++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/davinci-mcbsp.txt

Acked-by: Rob Herring <robh@kernel.org>
