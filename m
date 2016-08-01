From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 1 Aug 2016 19:09:06 +0200
Subject: [PATCH v2] mmc: sunxi: Handle the 'New Timings'
In-Reply-To: <CAGb2v67ocbAVhUA530JC9OiOW8ozybTgP+3yzjPomMKKwP-Bcg@mail.gmail.com>
References: <20160801133359.5B1802E03D@muse.csie.ntu.edu.tw>
 <CAGb2v67ocbAVhUA530JC9OiOW8ozybTgP+3yzjPomMKKwP-Bcg@mail.gmail.com>
Message-ID: <20160801190906.8e7b86044aa32afda1a11e97@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

On Mon, 1 Aug 2016 21:52:48 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

> On Mon, Aug 1, 2016 at 9:10 PM, Jean-Francois Moine <moinejf@free.fr> wrote:
> > Some MMC devices as mmc2 in the A83T or mmc1 and mmc2 in the H3 have
> > a 'New Timings' mode.
> > Set this capacity in the DT and use it when possible.
> 
>            ^^ capability?
> 
> Also, in this patch you are adding support for a DT boolean flag
> property, not adding stuff to the DT.

Sorry, forgotten.

> >
> > Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> > ---
> 
> I got 3 copies of the same patch...

Maybe because I sent it to you, and to the mmc and sunxi lists.

> > I don't know if this mode works or is needed at 25MHz.
> 
> Could you test it? You can change mmc->f_max in the probe function
> to limit it to 25 MHz.
> 
> I'm more interested in the throughput you get after applying this
> patch though.

I did a test on a BPI-M2+ (H3). The new timings don't work at 25MHz,
neither for mmc1 (wifi) - nor for mmc2 (eMMC).

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
