From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 27 Jan 2016 10:37:14 +0100
Subject: [linux-sunxi] Problem with Allwinner H3 clocks
In-Reply-To: <CAGb2v65FUhNC-d-YT=-2adNHHT6b1JvGoNTFLfBX_xBSnuOsTg@mail.gmail.com>
References: <20160127084607.665fb8c38eeb5733ce4232da@free.fr>
 <CAGb2v65FUhNC-d-YT=-2adNHHT6b1JvGoNTFLfBX_xBSnuOsTg@mail.gmail.com>
Message-ID: <20160127103714.58312b152adb4148bae2f93b@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Jan 2016 16:18:53 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

> Hi,

Hi ChenYu,

> On Wed, Jan 27, 2016 at 3:46 PM, Jean-Francois Moine <moinejf@free.fr> wrote:
> > Hi Jens,
> >
> > My H3 machine (OPI2) cannot boot with the PLL6 (periph0) as defined
> > in the kernel 4.5-rc1. As there is no UART, I don't know what is wrong.
> >
> > But, applying your old patch
> >
> > [PATCH v4 1/6] clk: sunxi: Let divs clocks read the base factor clock name from devicetree
> > (https://lkml.org/lkml/2015/10/27/532)
> >
> > makes everything work correctly again (thanks to other patches, I have
> > 4 CPUs, USB, thermal sensor and video).
> >
> > Any idea?
> 
> What kernel and DTS are you using? What other patches have you applied?

About the clock problem, I tried the 4.5-rc1 kernel with its included DTs
(sun8i-h3-orangepi-plus.dts) without patch. No UART.
Changing the PLL6 (and the phandles in the DT) makes the UART work.

> Patches for H3 USB, thermal sensor and video have not been merged, so it's
> likely to have some integration problems. FYI you should always check the
> result after self-applying or rebasing DT patches, as there isn't enough
> context for git to know if a patch has been applied or not.

Many patches (USB) are available in Hans de Goede's repository.
Some other ones either work fine directly from their submission
(thermal sensor) or ask for few changes (PRCM).
Video is my development. I will submit a new patch series as soon as
the hardware cursor works.

> 4.5-rc1 + sunxi-next boots fine on my Orange PI PC, using the Orange PI Plus
> DTS for now.

Strange! I already had this problem when Jens removed his work about
PLL6 in his H3 patch series. At this time, I was thinking about a merge
error of mine...

-- 
A galon		|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
