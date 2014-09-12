From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 12 Sep 2014 13:43:39 -0300
Subject: [PATCH V1 1/3] ARM: clk-imx6sl: refine clock tree for SSI
In-Reply-To: <CAOMZO5A4FLbA_+u4oMTqgAY69DaF93V=oLiy+op=tEHbagF1pg@mail.gmail.com>
References: <cover.1410253534.git.shengjiu.wang@freescale.com>
 <7ed21195ebff8b3ccbecaeb492504edd28deea2d.1410253534.git.shengjiu.wang@freescale.com>
 <CAOMZO5A4FLbA_+u4oMTqgAY69DaF93V=oLiy+op=tEHbagF1pg@mail.gmail.com>
Message-ID: <CAOMZO5DJZHKAV4Y9aUwMNWZqhoLrKrsZdYnKqPem2ZSy=-oAYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 12, 2014 at 1:35 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Tue, Sep 9, 2014 at 6:13 AM, Shengjiu Wang
> <shengjiu.wang@freescale.com> wrote:
>> Each SSI has "ssi", "ssi_ipg" clocks, and they share same gate bits.
>>
>> Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
>
> This patch breaks audio playback on imx6q-sabresd:
>
> root at freescale /$ aplay /home/clarinet.wav
> Playing WAVE '/home/clarinet.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
> Mono
> underrun!!! (at least -1585992.581 ms long)
> underrun!!! (at least -1585992.585 ms long)
> underrun!!! (at least -1585992.586 ms long)
> underrun!!! (at least -1585992.586 ms long)
> underrun!!! (at least -1585992.586 ms long)
> underrun!!! (at least -1585992.586 ms long)
> underrun!!! (at least -1585992.586 ms long)
> underrun!!! (at least -1585992.586 ms long)
> underrun!!! (at least -1585992.586 ms long)
> underrun!!! (at least -1585992.586 ms long)
>
> If I revert this commit, then I am able to play it well again.

Ops, I replied in the wrong patch.

The one that breaks imx6q-sabresd is:

   commit 48e1c2255 "ARM: clk-imx6q: refine clock tree for SSI"
