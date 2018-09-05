From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 05 Sep 2018 23:50:25 +0300
Subject: [PATCH 3/6] dt-bindings: display: add data-enable polarity
 property
In-Reply-To: <e708c5bac502e60a2eeb685fddf67042@agner.ch>
References: <20180905052113.21262-1-stefan@agner.ch>
 <139651706.L0sBFfZMDQ@avalon> <e708c5bac502e60a2eeb685fddf67042@agner.ch>
Message-ID: <6830776.vZAoroGVFQ@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Wednesday, 5 September 2018 21:10:08 EEST Stefan Agner wrote:
> On 05.09.2018 00:07, Laurent Pinchart wrote:
> > On Wednesday, 5 September 2018 08:21:10 EEST Stefan Agner wrote:
> >> Allow to specify the data-enable polarity required by a dumb VGA
> >> DAC converting parallel RGB to VGA.
> >> 
> >> Signed-off-by: Stefan Agner <stefan@agner.ch>
> >> ---
> >> 
> >>  .../devicetree/bindings/display/bridge/dumb-vga-dac.txt          | 1 +
> >>  1 file changed, 1 insertion(+)
> >> 
> >> diff --git
> >> a/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
> >> b/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt index
> >> 164cbb15f04c..adbd2ca0af2f 100644
> >> --- a/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
> >> +++ b/Documentation/devicetree/bindings/display/bridge/dumb-vga-dac.txt
> >> @@ -18,6 +18,7 @@ graph bindings specified in
> >> Documentation/devicetree/bindings/graph.txt.
> >> 
> >>  Optional properties:
> >>  - vdd-supply: Power supply for DAC
> >> 
> >> +- de-active: data-enable pulse is active low/high/ignored
> > 
> > Which value corresponds to low, high and ignored ?
> 
> The wording is taken from
> Documentation/devicetree/bindings/display/panel/display-timing.txt. But
> I agree, not very useful.
> 
> 0 is low active, 1 is high active, and none is using driver defaults.
> 
> How about:
> - de-active: data-enable pulse is 0=active low/1=active high

The data enable signal isn't really a pulse. I would word this as

- de-active: Polarity of the data enable signal. 0 for active low, 1 for 
active high, unset for system-specific defaults.

> >>  Example
> >>  -------

-- 
Regards,

Laurent Pinchart
