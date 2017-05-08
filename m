From: robh@kernel.org (Rob Herring)
Date: Mon, 8 May 2017 11:24:43 -0500
Subject: [PATCH v2 17/20] dt-bindings: display: sun4i: Add
 allwinner,tcon-channel property
In-Reply-To: <2f00be9d75b68090ffed30654be65132a156a317.1493812478.git-series.maxime.ripard@free-electrons.com>
References: <cover.d697f34bb7b0605c5e76cbc4167a64453e5e0984.1493812478.git-series.maxime.ripard@free-electrons.com>
 <2f00be9d75b68090ffed30654be65132a156a317.1493812478.git-series.maxime.ripard@free-electrons.com>
Message-ID: <20170508162443.faox4hm6jmfqccwt@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 03, 2017 at 01:59:54PM +0200, Maxime Ripard wrote:
> The Allwinner Timings Controller has two, mutually exclusive, channels.
> When the binding has been introduced, it was assumed that there would be
> only a single user per channel in the system.
> 
> While this is likely for the channel 0 which only connects to LCD displays,
> it turns out that the channel 1 can be connected to multiple controllers in
> the SoC (HDMI and TV encoders for example). And while the simultaneous use
> of HDMI and TV outputs cannot be achieved, switching from one to the other
> at runtime definitely sounds plausible.
> 
> Add an extra property, allwinner,tcon-channel, to specify for a given
> endpoint which TCON channel it is connected to, while falling back to the
> previous mechanism if that property is missing.
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 11 ++++---
>  1 file changed, 7 insertions(+), 4 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
