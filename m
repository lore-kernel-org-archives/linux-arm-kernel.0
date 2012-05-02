From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 2 May 2012 11:37:13 +0800
Subject: [alsa-devel] [PATCH 10/11] ARM: imx6q_sabrelite: clkdev_add cko1
 for sgtl5000
In-Reply-To: <CAOMZO5Ab5pYuOY4oLbkOc+SeeT6itKOMJu+zzodFOJaW5h+RuQ@mail.gmail.com>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
 <1335510185-7906-11-git-send-email-richard.zhao@freescale.com>
 <20120501124706.GF2194@S2101-09.ap.freescale.net>
 <20120501233939.GO2194@S2101-09.ap.freescale.net>
 <CAOMZO5Ab5pYuOY4oLbkOc+SeeT6itKOMJu+zzodFOJaW5h+RuQ@mail.gmail.com>
Message-ID: <20120502033711.GW2194@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 01, 2012 at 11:47:55PM -0300, Fabio Estevam wrote:
> On Tue, May 1, 2012 at 8:39 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > On Tue, May 01, 2012 at 08:47:10PM +0800, Shawn Guo wrote:
> >> > + ? clk_register_clkdev(cko1, NULL, "0-000a");
> >>
> >> This dev_id looks a little strange to me. ?I understand that's the
> >> consequence of having sgtl5000 clock managed in ASoC machine driver
> >> imx-sgtl5000.
> >>
> > Just realised it's not the case. ?But shouldn't the name look like
> > "sgtl5000.0-000a"?
> 
> Since this is common code, we should not hardcode the I2C bus as the
> codec can be connected in a I2C bus different of 0.

No, it's not.  It's a sabrelite specific lookup which is done in
imx6q_sabrelite_init, while imx6q_cko1_setup needs a better naming,
as what I already commented.

In the end, this type of board specific clock lookup should really
go into device tree.

-- 
Regards,
Shawn
