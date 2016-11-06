From: moinejf@free.fr (Jean-Francois Moine)
Date: Sun, 6 Nov 2016 19:02:48 +0100
Subject: [linux-sunxi] [PATCH v5 4/7] ASoC: sunxi: Add sun8i I2S driver
In-Reply-To: <CAGb2v67gDd650TJk_-oHOehnzdH2qor=36HXdPt339Ji=ToAMg@mail.gmail.com>
References: <cover.1477142934.git.moinejf@free.fr>
 <bee315efb909c1ee8b5fe7d3aeb9a33d713cb562.1477142934.git.moinejf@free.fr>
 <CAGb2v67gDd650TJk_-oHOehnzdH2qor=36HXdPt339Ji=ToAMg@mail.gmail.com>
Message-ID: <20161106190248.48b59e166bcd9d6f0ebb4d04@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 23 Oct 2016 09:33:16 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

> On Fri, Oct 21, 2016 at 4:36 PM, Jean-Francois Moine <moinejf@free.fr> wrote:
> > This patch adds I2S support to sun8i SoCs as the A83T and H3.
> >
> > Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> > ---
> > Note: This driver is closed to the sun4i-i2s except that:
> > - it handles the H3
> 
> If it's close to sun4i-i2s, you should probably rework that one to support
> the newer SoCs.

I started to add the H3 into the sun4i-i2s, but I am blocked with
regmap.
Many H3 registers are common with the A10, but some of them have more
or less fields, the fields may be at different offsets. And, finally,
some registers are completely different.
This would not raise any problem, except with regmap which is really
painful.

As I may understood, regmap is used to simplify suspend/resume, but, is
it useful to save the I2S register on suspend?
Practically, I am streaming some tune on my device. I suspend it for
any reason. The next morning, I resume it. Are you sure I want to
continue to hear the end of the tune?

I better think that streaming should be simply stopped on suspend.
Then, there is no need to save the playing registers, and, here I am,
there is no need to use regmap.

May I go this way?

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
