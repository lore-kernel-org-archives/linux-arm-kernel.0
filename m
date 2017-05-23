From: dianders@chromium.org (Doug Anderson)
Date: Tue, 23 May 2017 08:57:01 -0700
Subject: [PATCH 2/2] arm64: dts: rockchip: introduce rk3399-op1 operating
 points
In-Reply-To: <20170523095109.7337-2-heiko@sntech.de>
References: <20170523095109.7337-1-heiko@sntech.de>
 <20170523095109.7337-2-heiko@sntech.de>
Message-ID: <CAD=FV=XbUjuvt+ctm8Xw6JPqe7m4PdyZ1hm3Uast2+1+nJ=nPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, May 23, 2017 at 2:51 AM, Heiko Stuebner <heiko@sntech.de> wrote:
> The OP1 is a rk3399 variant used in ChromeOS devices with a slightly
> higher frequency rating. Therefore introduce separate operting points,
> from the ChromeOS tree, for it and use it in Gru devices.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi     |   2 +-
>  arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi | 145 +++++++++++++++++++++++
>  2 files changed, 146 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi

The numbers here match what's in the Chrome OS tree and those were all
approved by Rockchip.

One slight nit is that the descriptions these two patches together
make it look like this will be a no-op change for OP1 devices.  This
is not true.  After things were posted upstream there have been
several adjustments to the opp points in the Chrome OS tree.  Since
what you have currently matches the ToT Chrome OS tree, that should
mean that there's a net difference.  It would be nice to mention that
in the commit message.

Other than that small nit:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
