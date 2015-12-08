From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 8 Dec 2015 10:19:49 +0100
Subject: [PATCH v5 3/4] ARM: dts: sunxi: Add Allwinner H3 DTSI
In-Reply-To: <20151208083224.GN27957@lukather>
References: <1449264283-25360-1-git-send-email-jenskuske@gmail.com>
 <1449264283-25360-4-git-send-email-jenskuske@gmail.com>
 <20151207091257.070723b67db726d9f05c6550@free.fr>
 <5665D38E.4050406@gmail.com>
 <20151208090658.e471fcde7fd5e79c69706115@free.fr>
 <20151208083224.GN27957@lukather>
Message-ID: <20151208101949.4c596117eb3b6b4551dd0cea@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 8 Dec 2015 09:32:24 +0100
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> If the H3 display block is done the same way than the A10 (and later)
> one on this aspect, then the TCON has two channels with two different
> streaming (or functional, you pick the name) clocks. The channel 0 is
> usually used for RGB, the channel 1 for HDMI, composite and VGA.
> 
> Maybe they just added different bus gates for those two different
> channels, and moved HDMI to the channel 0.
> 
> Anyway, that can always be changed later on if we have more clue on
> what's going on.

I don't know about the other Allwinner chips, and your DRM driver for
these ones cannot be reused for the H3 because its display engine
(DE.2) is completely different.

The DE2 runs at 432MHz and treats both LCDs. The TCON1 runs at a fixed
rate, 200MHz, and the streaming rates are defined by the HDMI (LCD0) and
TCON0 (LCD1) clocks.

BTW, I hope to submit a H3 DRM driver before new year.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
