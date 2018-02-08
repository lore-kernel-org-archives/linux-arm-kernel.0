From: ryder.lee@mediatek.com (Ryder Lee)
Date: Thu, 8 Feb 2018 13:57:27 +0800
Subject: [PATCH v2 2/5] clk: mediatek: modify MT7622 audsys to adapt MFD
 device
In-Reply-To: <0e0e703c-0ac9-06ad-91c5-abdf16de1ee9@gmail.com>
References: <cover.1515639336.git.ryder.lee@mediatek.com>
 <d6669277f5232446b4798a6b724074b18d5c21aa.1515639336.git.ryder.lee@mediatek.com>
 <72058f8d-c83d-d0e6-dc07-83c9f5fc2710@gmail.com>
 <1517803655.1173.12.camel@mtkswgap22>
 <0e0e703c-0ac9-06ad-91c5-abdf16de1ee9@gmail.com>
Message-ID: <1518069447.28878.4.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-02-07 at 16:18 +0100, Matthias Brugger wrote:
> 
> On 02/05/2018 05:07 AM, Ryder Lee wrote:
> > On Sat, 2018-02-03 at 15:26 +0100, Matthias Brugger wrote:
> >>
> >> On 01/31/2018 08:42 AM, Ryder Lee wrote:
> >>> As the new MFD parent is in place, switch probing method to adapt it.
> >>>
> >>> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> >>> ---
> >>>  drivers/clk/mediatek/clk-mt7622-aud.c | 3 ++-
> >>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/clk/mediatek/clk-mt7622-aud.c b/drivers/clk/mediatek/clk-mt7622-aud.c
> >>> index 13f752d..8c18536 100644
> >>> --- a/drivers/clk/mediatek/clk-mt7622-aud.c
> >>> +++ b/drivers/clk/mediatek/clk-mt7622-aud.c
> >>> @@ -142,11 +142,12 @@ static int clk_mt7622_audiosys_init(struct platform_device *pdev)
> >>>  {
> >>>  	struct clk_onecell_data *clk_data;
> >>>  	struct device_node *node = pdev->dev.of_node;
> >>> +	struct device_node *pnode = pdev->dev.parent->of_node;
> >>>  	int r;
> >>>  
> >>>  	clk_data = mtk_alloc_clk_data(CLK_AUDIO_NR_CLK);
> >>>  
> >>> -	mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
> >>> +	mtk_clk_register_gates(pnode, audio_clks, ARRAY_SIZE(audio_clks),
> >>
> >> We will need a fallback here for older device tree bindings.
> >>
> >> Regards,
> >> Matthias
> > 
> > Up to now, I didn't see both driver and bindings are used anywhere.
> > Should I still care about that?
> > 
> 
> Yes please, we have to ensure that newer kernel work with older bindings and
> vice-versa.

OKay. An unrelated question - is it possible to change the compatible
string (*-audsys-clk) without breaking backward compatible?
