From: horms@verge.net.au (Simon Horman)
Date: Mon, 1 May 2017 11:11:15 +0200
Subject: [PATCH v2 0/5] arm64: dts: renesas: Break out common board support
In-Reply-To: <1493384324-29344-1-git-send-email-geert+renesas@glider.be>
References: <1493384324-29344-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170501091114.GI18349@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 28, 2017 at 02:58:39PM +0200, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> The Renesas Salvator-X and ULCB development board can be equipped with
> either an R-Car H3 or M3-W SiP, which are pin-compatible.  All boards
> use separate DTBs, but currently there's no sharing of board-specific
> devices in DTS.
> 
> This series reduces duplication by extracting common board support into
> their own .dtsi files.  As the level of support varies across boards and
> SoCs, this requires the addition of a few external clocks and
> placeholder devices on R-Car M3-W, so the common board support DTS can
> refer to them.
> 
>   - Patches 1 and 2 add the external audio and PCIe bus clocks on R-Car
>     M3-W, which are present in r8a7795.dtsi, and used in
>     r8a7795-salvator-x.dts,
>   - Patch 3 adds placeholders for devices that are not yet supported
>     and/or tested on R-Car M3-W, but used on R-Car H3,
>   - Patch 4 extracts common Salvator-X board support,
>   - Patch 5 extracts common ULCB board support.
> 
> For R-Car H3 based boards, there are no functional changes.
> For R-Car M3-W based boards, some new devices are now described in DT.
> 
> Compared to v1, the most important change is a rebase to remove the
> dependency on "[PATCH 0/8] arm64: dts: renesas: Break out R-Car H3 and
> M3-W SiP" (http://www.spinics.net/lists/devicetree/msg173820.html).
> Please refer to the individual patches for more changelog information.
> 
> Dependencies:
>   - renesas-devel-20170428-v4.11-rc8.
> 
> DTB changes have been inspected using scripts/dtc/dtx_diff.
> This has been tested on Salvator-X (both H3 and M3-W), H3ULCB, and
> M3ULCB.
> 
> Thanks for applying!

Thanks, done.
