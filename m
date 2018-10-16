From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 16 Oct 2018 13:49:45 +0200
Subject: [PATCH v4 0/9] Add support for audiocodec in Allwinner A64
In-Reply-To: <CA+E=qVdA06n3Q=UP_gp05Ah2tf2UC-hOUCS471D_D6d2v-yF2A@mail.gmail.com>
References: <20181016030239.15449-1-anarsoul@gmail.com>
 <20181016070843.j6vnmk6qij6rdjbm@flea>
 <CA+E=qVdA06n3Q=UP_gp05Ah2tf2UC-hOUCS471D_D6d2v-yF2A@mail.gmail.com>
Message-ID: <20181016114945.ghigmd5oxm2je7jc@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2018 at 12:13:26AM -0700, Vasily Khoruzhick wrote:
> On Tue, Oct 16, 2018, 00:09 Maxime Ripard <[1]maxime.ripard@bootlin.com> wrote:
> 
>     Hi,
> 
>     On Mon, Oct 15, 2018 at 08:02:30PM -0700, Vasily Khoruzhick wrote:
>     > This series adds Allwinner A64 audiocodec support into sun4i-i2s,
>     > sun8i-codec drivers, introduces new sun50i-codec-analog driver and
>     enables
>     > sound on Pine64, SoPine boards and Pinebook.
>     >
>     > I2S for audiocodec in A64 is different from other 3 I2S modules but
>     > similar to one in A10, digital part of codec is compatible with A33 and
>     > analog controls part is completely different from other SoCs - it shares
>     > only few bits in few registers, so adding support for it into existing
>     > sun8i-codec-analog would mean duplicating all the widgets, controls and
>     > some routes and making it hard to read. Therefore it makes sense to
>     > introduce new driver.
>     >
>     > v2: - Use simple-amplifier for speaker amp on Pinebook
>     >? ? ?- Rename sun50i-a64-i2s to sun50i-a64-codec-i2s to preserve
>     compatible
>     >? ? ? ?string for other 3 I2S modules in A64 in case if there's any
>     >? ? ? ?incompatibility with H3
>     > v3: - renamed sunxi-adda-pr-regmap to sun8i-adda-pr-regmap
>     >? ? ?- use ilog2() to calculate reg value for LRCK div instead of using a
>     >? ? ? ?table
>     > v4: - dts: don't use 'Mic' and 'Headset Mic' widgets from sun8i-codec,
>     >? ? ? ?define our board-level widgets instead.
> 
>     You also need to collect the tags that are given by the various people
>     involved in that review :)
> 
> 
> My bad. Do you want me to send v5 with all the tags?

Yep, please, thankS!

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
