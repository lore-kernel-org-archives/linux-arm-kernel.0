From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 12 Sep 2014 13:35:48 -0300
Subject: [PATCH V1 1/3] ARM: clk-imx6sl: refine clock tree for SSI
In-Reply-To: <7ed21195ebff8b3ccbecaeb492504edd28deea2d.1410253534.git.shengjiu.wang@freescale.com>
References: <cover.1410253534.git.shengjiu.wang@freescale.com>
 <7ed21195ebff8b3ccbecaeb492504edd28deea2d.1410253534.git.shengjiu.wang@freescale.com>
Message-ID: <CAOMZO5A4FLbA_+u4oMTqgAY69DaF93V=oLiy+op=tEHbagF1pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 9, 2014 at 6:13 AM, Shengjiu Wang
<shengjiu.wang@freescale.com> wrote:
> Each SSI has "ssi", "ssi_ipg" clocks, and they share same gate bits.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>

This patch breaks audio playback on imx6q-sabresd:

root at freescale /$ aplay /home/clarinet.wav
Playing WAVE '/home/clarinet.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Mono
underrun!!! (at least -1585992.581 ms long)
underrun!!! (at least -1585992.585 ms long)
underrun!!! (at least -1585992.586 ms long)
underrun!!! (at least -1585992.586 ms long)
underrun!!! (at least -1585992.586 ms long)
underrun!!! (at least -1585992.586 ms long)
underrun!!! (at least -1585992.586 ms long)
underrun!!! (at least -1585992.586 ms long)
underrun!!! (at least -1585992.586 ms long)
underrun!!! (at least -1585992.586 ms long)

If I revert this commit, then I am able to play it well again.
