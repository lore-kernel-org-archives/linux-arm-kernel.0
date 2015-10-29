From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 29 Oct 2015 09:40:37 +0100
Subject: [PATCH v8 06/17] dt-bindings: add document for analogix display
 port driver
In-Reply-To: <56317275.90508@rock-chips.com>
References: <1446020143-32645-1-git-send-email-ykk@rock-chips.com>
 <103292898.nCEg51kmfI@phil> <56317275.90508@rock-chips.com>
Message-ID: <1689999.2MgYqJktlx@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 29. Oktober 2015, 09:12:21 schrieb Yakir Yang:
> Hi Heiko,
> 
> On 10/29/2015 04:02 AM, Heiko Stuebner wrote:
> > Hi Yakir,
> >
> > Am Mittwoch, 28. Oktober 2015, 16:26:33 schrieb Yakir Yang:
> >> diff --git a/Documentation/devicetree/bindings/display/exynos/exynos_dp.txt b/Documentation/devicetree/bindings/display/exynos/exynos_dp.txt
> >> index 7a3a9cd..9905081 100644
> >> --- a/Documentation/devicetree/bindings/display/exynos/exynos_dp.txt
> >> +++ b/Documentation/devicetree/bindings/display/exynos/exynos_dp.txt
> >> @@ -31,45 +31,31 @@ Required properties for dp-controller:
> >>   		from general PHY binding: the phandle for the PHY device.
> >>   	-phy-names:
> >>   		from general PHY binding: Should be "dp".
> >> -	-samsung,color-space:
> >> -		input video data format.
> >> -			COLOR_RGB = 0, COLOR_YCBCR422 = 1, COLOR_YCBCR444 = 2
> >> -	-samsung,dynamic-range:
> >> -		dynamic range for input video data.
> >> -			VESA = 0, CEA = 1
> >> -	-samsung,ycbcr-coeff:
> >> -		YCbCr co-efficients for input video.
> >> -			COLOR_YCBCR601 = 0, COLOR_YCBCR709 = 1
> >> -	-samsung,color-depth:
> >> -		number of bits per colour component.
> >> -			COLOR_6 = 0, COLOR_8 = 1, COLOR_10 = 2, COLOR_12 = 3
> >> -	-samsung,link-rate:
> >> -		link rate supported by the panel.
> >> -			LINK_RATE_1_62GBPS = 0x6, LINK_RATE_2_70GBPS = 0x0A
> >> -	-samsung,lane-count:
> >> -		number of lanes supported by the panel.
> >> -			LANE_COUNT1 = 1, LANE_COUNT2 = 2, LANE_COUNT4 = 4
> >> -	- display-timings: timings for the connected panel as described by
> >> -		Documentation/devicetree/bindings/video/display-timing.txt
> > 											^^ display/display-timings.txt
> > otherwise this patch does not apply.
> 
> I thought I have deleted this old path of "display-timing.txt", and 
> changed it to
> 
> -		Documentation/devicetree/bindings/video/display-timing.txt

in the changes I got from Rob Hering's dt-branch [0] the path in the file
is already display/display-timing.txt so applying a change with video/...
in it fails. Anyway, as this will probably only make it in after the merge-
window, we can see how this ends up before anyway :-) .

> 
> +		Documentation/devicetree/bindings/display/panel/display-timing.txt
> 
> And the real path of "display-timing.txt" in linux-next [tag 20151022] 
> do under
> the "display/panel/", those change should be right.


Heiko

[0] https://git.kernel.org/cgit/linux/kernel/git/robh/linux.git/commit/?h=dt/next&id=efdbd7345f8836f7495f3ac6ee237d86cb3bb6b0
