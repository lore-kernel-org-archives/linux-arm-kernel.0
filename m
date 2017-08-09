From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 9 Aug 2017 17:16:29 +0800
Subject: [linux-sunxi] [PATCH 2/4] drivers: soc: sunxi: fix error
 processing on base address when claiming
In-Reply-To: <20170809085627.32687-3-icenowy@aosc.io>
References: <20170809085627.32687-1-icenowy@aosc.io>
 <20170809085627.32687-3-icenowy@aosc.io>
Message-ID: <CAGb2v658CSUwSMdv5yCLtPSfDrsmMZDSBjZQsmi=2Y+EfJPmhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 9, 2017 at 4:56 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> When claiming SRAM, if the base is set to an error, it means that the
> SRAM controller has been probed, but failed to remap the controller
> memory zone. If the base is zero, thus the SRAM controller should be not
> probed at all, and it should return -EPROBE_DEFER. However, currently we
> returned -EPROBE_DEFER in the former situation, and ignored the latter
> situation (which will lead to the kernel to panic).
>
> Fix the behavior on abnormal base address processing when claiming.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Fixes: 4af34b572a85 ("drivers: soc: sunxi: Introduce SoC driver to map SRAMs") ?

I can add the tag when applying.

ChenYu
