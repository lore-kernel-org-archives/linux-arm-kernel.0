From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 20 Jan 2018 11:37:28 +0800
Subject: [PATCH] ARM: sunxi_defconfig: Enable CMA
In-Reply-To: <20180119133208.12873-1-maxime.ripard@free-electrons.com>
References: <20180119133208.12873-1-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v67wwa30E2GFaWEuLe1fEvCBmEy7H_3ystv460+1SAJGuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 19, 2018 at 9:32 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The DRM driver most notably, but also out of tree drivers (for now) like
> the VPU or GPU drivers, are quite big consumers of large, contiguous memory
> buffers. However, the sunxi_defconfig doesn't enable CMA in order to
> mitigate that, which makes them almost unusable.
>
> Enable it to make sure it somewhat works.

IIRC the default size for CMA pretty much limits it to small tablet
screen resolutions. Is this something we want to leave up to the
user?

Thanks
ChenYu
