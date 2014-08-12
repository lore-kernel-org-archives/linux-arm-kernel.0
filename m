From: dianders@chromium.org (Doug Anderson)
Date: Tue, 12 Aug 2014 10:26:45 -0700
Subject: [PATCH 3/6] ARM: dts: Create cros-tps65090 fragment
In-Reply-To: <1407861868-20097-4-git-send-email-javier.martinez@collabora.co.uk>
References: <1407861868-20097-1-git-send-email-javier.martinez@collabora.co.uk>
 <1407861868-20097-4-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <CAD=FV=XNsQ_8h-d8epU_gzWRH=A49a8iuirWCUe4TO6VGCvDSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier,

On Tue, Aug 12, 2014 at 9:44 AM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> The tps65090 PMU is a component used in many ChromeOS devices
> so instead of having the same device tree definitions in many
> files, create a .dtsi fragment that can be included in DTS.
>
> This fragment is based on the DT definitions for Peach boards.
>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  arch/arm/boot/dts/cros-tps65090.dtsi | 81 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 arch/arm/boot/dts/cros-tps65090.dtsi

I'd probably skip this patch (just have duplication in pit vs. pi), or
make it "peach" specific (like exynos-peach-tps65090.dtsi?).  This is
really board-specific info and trying to guess what the various FETs
are going to be for for all peach variants doesn't seem great.

-Doug
