From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 11 Sep 2015 14:56:34 -0700
Subject: [PATCH 3/3] arm64: dts: mt8173: Add nor flash node
In-Reply-To: <1441965076.23394.7.camel@mhfsdcap03>
References: <1441705796-11365-1-git-send-email-bayi.cheng@mediatek.com>
 <1441705796-11365-4-git-send-email-bayi.cheng@mediatek.com>
 <CAD6G_RTR2r8ETMQ14uGosRn-85sssvVsFT4BjK9SkVSfMkG8Dw@mail.gmail.com>
 <CAAEAJfCg+O=b9pfndG2WfxKVk9gvcqHUL0MV4fDpHj_9CaCBbQ@mail.gmail.com>
 <55EF7346.5040607@kernel.org> <1441965076.23394.7.camel@mhfsdcap03>
Message-ID: <20150911215634.GF11487@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 11, 2015 at 05:51:16PM +0800, bayi.cheng wrote:
> On Tue, 2015-09-08 at 18:46 -0500, Rob Herring wrote:
> > On 09/08/2015 10:18 AM, Ezequiel Garcia wrote:
> > > On 8 September 2015 at 08:53, Jagan Teki <jteki@openedev.com> wrote:
> > >> On 8 September 2015 at 15:19, Bayi Cheng <bayi.cheng@mediatek.com> wrote:
> > >>> Add Mediatek nor flash node
> > >>>
> > >>> Signed-off-by: Bayi Cheng <bayi.cheng@mediatek.com>
> > >>> ---
> > >>>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 10 ++++++++++
> > >>>  1 file changed, 10 insertions(+)
> > >>>
> > >>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > >>> index d18ee42..a14f005 100644
> > >>> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > >>> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > >>> @@ -365,6 +365,16 @@
> > >>>                         status = "disabled";
> > >>>                 };
> > >>>
> > >>> +               nor_flash: nor at 1100d000 {
> > >>
> > >> Based on the comments from 1/3 - this notation needs to be change something like
> > >> qspi0: quadspi at 1100d000
> > >>
> > > 
> > > Actually, to follow ePAPR recomendations it should be named as flash at 1100d000.
> > > (See ePAPR, 2.2.2 Generic Names Recommendation).
> > 
> > The flash device node should, but this is the controller which should be
> > "spi" IMO even if this is not a general purpose controller.
> > 
> > Rob
> > 
> HI Rob, Thanks for your instruct! I will fix it !

OK, so given there are several cooks in the kitchen, and I just read
these replies after replying independently to the binding doc, I'll try
to summarize the consensus, flavored with my own opinion:

 * the node name should not be 'nor'; it should be something more along
   the lines of ePAPR. So 'flash' or 'spi'
 * the phandle name is less important, and can be more descriptive
 * there should be a subnode to represent the flash separately from the
   controller

So we might put this together to:

	whatever_name_you_like: spi at 1100d000 {
		...
		flash at 0 {
			...
		};
	};

Brian
