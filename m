From: julian.calaby@gmail.com (Julian Calaby)
Date: Sun, 20 May 2018 11:50:25 +1000
Subject: [linux-sunxi] [PATCH 07/15] dt-bindings: display: sun4i-drm: Add
 R40 HDMI pipeline
In-Reply-To: <20180519183127.2718-8-jernej.skrabec@siol.net>
References: <20180519183127.2718-1-jernej.skrabec@siol.net>
 <20180519183127.2718-8-jernej.skrabec@siol.net>
Message-ID: <CAGRGNgU+PaygxkVkfcxUqMeV1TijJrZRkPkff7b4cxdVY6NQLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jernej,

On Sun, May 20, 2018 at 4:31 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> Missing compatibles and descriptions needed to implement R40 HDMI
> pipeline are added.
>
> For mixers only compatibles are added.
>
> TCON description is expanded with R40 TV TCON compatibles. If the SoC
> has TCON TOP unit, phandle to that unit has to be specified. Additional
> clock has to be specified if SoC has TCON TOP and TCON is TV TCON.
>
> New compatible is added for DWC HDMI PHY, which has additional clock
> specified.

There's a bunch of A64 related stuff mixed in here, is the R40
compatible with the A64's parts? If so, you should probably mention
that in the commit log.

> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  .../bindings/display/sunxi/sun4i-drm.txt         | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> index a099957ab62a..634276f713e8 100644
> --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> @@ -111,8 +112,9 @@ Required properties:
>    - resets: phandle to the reset controller driving the PHY
>    - reset-names: must be "phy"
>
> -H3 HDMI PHY requires additional clock:
> +H3 and A64 HDMI PHY requires additional clocks:
>    - pll-0: parent of phy clock
> +  - pll-1: second possible phy clock parent (A64 only)

Maybe split this into two:

H3 HDMI PHY ...
   - pll-0: ...

A64 HDMI PHY ...
   - pll-0: ...
   - pll-1: ...

At the moment a quick reading implies that H3 needs pll-1.

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
