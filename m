From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 27 Jan 2016 16:18:53 +0800
Subject: [linux-sunxi] Problem with Allwinner H3 clocks
In-Reply-To: <20160127084607.665fb8c38eeb5733ce4232da@free.fr>
References: <20160127084607.665fb8c38eeb5733ce4232da@free.fr>
Message-ID: <CAGb2v65FUhNC-d-YT=-2adNHHT6b1JvGoNTFLfBX_xBSnuOsTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jan 27, 2016 at 3:46 PM, Jean-Francois Moine <moinejf@free.fr> wrote:
> Hi Jens,
>
> My H3 machine (OPI2) cannot boot with the PLL6 (periph0) as defined
> in the kernel 4.5-rc1. As there is no UART, I don't know what is wrong.
>
> But, applying your old patch
>
> [PATCH v4 1/6] clk: sunxi: Let divs clocks read the base factor clock name from devicetree
> (https://lkml.org/lkml/2015/10/27/532)
>
> makes everything work correctly again (thanks to other patches, I have
> 4 CPUs, USB, thermal sensor and video).
>
> Any idea?

What kernel and DTS are you using? What other patches have you applied?

Patches for H3 USB, thermal sensor and video have not been merged, so it's
likely to have some integration problems. FYI you should always check the
result after self-applying or rebasing DT patches, as there isn't enough
context for git to know if a patch has been applied or not.

4.5-rc1 + sunxi-next boots fine on my Orange PI PC, using the Orange PI Plus
DTS for now.


Regards
ChenYu
