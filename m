From: briannorris@chromium.org (Brian Norris)
Date: Mon, 20 Mar 2017 16:03:37 -0700
Subject: [PATCH 2/2] arm64: dts: add arm/arm64 include symlinks
In-Reply-To: <20170226060058.5841-2-heiko@sntech.de>
References: <20170226060058.5841-1-heiko@sntech.de>
 <20170226060058.5841-2-heiko@sntech.de>
Message-ID: <20170320230337.GB78325@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Feb 26, 2017 at 07:00:58AM +0100, Heiko Stuebner wrote:
> Allow including of dtsi files in an architecture-independent manner.
> Some dtsi files may be shared between architectures and one suggestion
> was to have symlinks and let these includes get accessed via a
>     #include <arm64/foo.dtsi>
> So add the necessary symlinks for arm32.
> 
> Suggested-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> Suggested by Olof in response to the patch adding direct symlinks
> for cros-ec includes.
> 
> Tested with adapted rk3399-Gru dtsi files and while we only need this arm64
> version right now, it might make sense to already have both the arm32 and
> arm64 versions ready.

FWIW, tested fine here too (for the same platform).

I guess this works fine, if it makes people happy. It also allows some
weird #include paths. e.g.:

#include <arm64/include/arm/include/arm64/rockchip/rk3399.dtsi>

I guess we can call that an entertaining feature, and not a bug?

Reviewed-by: Brian Norris <briannorris@chromium.org>
Tested-by: Brian Norris <briannorris@chromium.org>

Where should this go? I'd like not to wait another few months before
sending my Gru/Kevin DTS again.

Brian

>  arch/arm64/boot/dts/include/arm   | 1 +
>  arch/arm64/boot/dts/include/arm64 | 1 +
>  2 files changed, 2 insertions(+)
>  create mode 120000 arch/arm64/boot/dts/include/arm
>  create mode 120000 arch/arm64/boot/dts/include/arm64
> 
> diff --git a/arch/arm64/boot/dts/include/arm b/arch/arm64/boot/dts/include/arm
> new file mode 120000
> index 000000000000..cf63d80e2b93
> --- /dev/null
> +++ b/arch/arm64/boot/dts/include/arm
> @@ -0,0 +1 @@
> +../../../../arm/boot/dts
> \ No newline at end of file
> diff --git a/arch/arm64/boot/dts/include/arm64 b/arch/arm64/boot/dts/include/arm64
> new file mode 120000
> index 000000000000..a96aa0ea9d8c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/include/arm64
> @@ -0,0 +1 @@
> +..
> \ No newline at end of file
> -- 
> 2.11.0
> 
