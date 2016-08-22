From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 22 Aug 2016 08:28:56 +0200
Subject: [linux-sunxi] [PATCH v2 0/3] clk: sunxi-ng: Add the A83T clocks
In-Reply-To: <CAEzqOZuGbn0Qc62mLpPKuH+n8doVLQec5Lg-cvT2C5tqh1GFzg@mail.gmail.com>
References: <cover.1465666788.git.moinejf@free.fr>
 <CAEzqOZuGbn0Qc62mLpPKuH+n8doVLQec5Lg-cvT2C5tqh1GFzg@mail.gmail.com>
Message-ID: <20160822082856.6ca0aa6705bbadb70edb2330@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Aug 2016 02:23:51 +0800
Vishnu Patekar <vishnupatekar0510@gmail.com> wrote:

> Thanks for followup patches for a83t modern clock.
> 
> well, this patch series does not apply on sunxi/for-next.

Hi Vishnu,

This series is rather old!
Well, at this time, I was thinking that the 'modern' clock (aka
sunxi-ng) was a good thing, but, just after sending this series, I was
blocked, mainly because of the 'new timing' of the MMC clocks.
So, I rewrote and simplified the sunxi clock driver, and I submitted a
'ccu' patch which was refused by Maxime and Mike.

Actually, my 'ccu' driver is almost finished. The code is only 1200
lines in one file. It contains optimized computation of the clock
parameters, handles the H3 CPU frequency, the MMC 'new timing',
sigma-delta modulation for the audio PLL, the PRCM clocks and more.
The SoC specific tables (actually H3 and A83T) are about 10kB, but they
are defined as templates in .init.rodata, so that only the tables of the
current SoC remain in memory after system init.

This driver works fine for my Allwinner's boards and I will never go
back to the 'sunxi-ng' which is rather complex and lacks of flexibility.
If you are interested, the source is available in my site (see below).

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
