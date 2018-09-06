From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 6 Sep 2018 11:26:29 +0200
Subject: [PATCH/RFT] arm64: dts: renesas: r8a77995-draak: Add MSIOF ch2
 pins support
In-Reply-To: <20180906091827.jauhvbq6cudanlzl@verge.net.au>
References: <1536092527-5950-1-git-send-email-ykaneko0929@gmail.com>
 <20180906091827.jauhvbq6cudanlzl@verge.net.au>
Message-ID: <CAMuHMdUci+P9YqDpfmeBP1peKT+a4b9FbF4FSv-9Wq2n87bZdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Thu, Sep 6, 2018 at 11:18 AM Simon Horman <horms@verge.net.au> wrote:
> On Wed, Sep 05, 2018 at 05:22:07AM +0900, Yoshihiro Kaneko wrote:
> > From: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
> >
> > This patch adds support for MSIOF ch2 pinctrl to use the LVDS Control
> > Connector (CN41) for the Draak board on the R8A77995 SoC.
> >
> > Signed-off-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
> > Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > [ykaneko0929 at gmail.com: deleted the unused reference to 'msiof_ref_clk']
> > Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
>
> Hi Kaneko-san,
>
> sorry about this but I think we should drop this patch as
> it is my understanding that msiof2 is not used on the Draak board.

The connector is described in the Hardware Manual as "LVDS CONT connector"
in the LVDS chaper, but it is not clear to me what exactly is supposed to
be connected to it, and how standard it is.
Laurent: do you know more?

Note that Ebisu has the same connector, but the signals are shared with
SW4, making them mutually exclusive.
The Ebisu Hardware Manual does mention the connector, but not in the
Display Output (LVDS) chapter.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
