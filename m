From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 26 Jul 2016 19:43:06 +0200
Subject: [PATCH 4/9] clk: sunxi-ng: mux: Add support for mux tables
In-Reply-To: <1469516671-19377-5-git-send-email-wens@csie.org>
References: <1469516671-19377-1-git-send-email-wens@csie.org>
 <1469516671-19377-5-git-send-email-wens@csie.org>
Message-ID: <20160726194306.9b6aadd3d1669bd6f5a54d99@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Jul 2016 15:04:26 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

> Some clock muxes have holes, i.e. invalid or unconnected inputs,
> between parent mux values.
> 
> Add support for specifying a mux table to map clock parents to
> mux values.

Putting empty strings in the holes should work. No?
Ex:

static const char * const csi_mclk_parents[] =
	{ "pll-video0", "pll-video1", "", "", "", "osc24M" };

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
