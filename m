From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 1 May 2015 11:14:06 +0200
Subject: [PATCH 0/4] clk: si5351: Some fixes
In-Reply-To: <1430415954-29517-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1430415954-29517-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20150501111406.0aa23c7b@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 30 Apr 2015 19:45:50 +0200
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:

> For Si5351 clock driver, Michael Welling and Jean-Francois Moine reported
> issues with recent v4.x kernels due to broken/missing/wrong parent clock
> claming. This patch set now deals with the issues reported.
> 
> Patch 1 amends the binding documentation mention clock-names property
> for the "xtal" and "clkin" parent clock inputs of Si5351 variants.
> 
> Patch 2 adds the clock-names property for the SolidRun CuBox using Si5351
> with a fixed oscillator connected to "xtal" input.
> 
> Patch 3 reworks the way we claim parent clocks by using devm_clk_get()
> for both DT and platform_data based registration. Also, properly check
> for errors returned by devm_clk_get() and prepare/enable the parent clocks.
> 
> Patch 4 introduces a function to reset PLLs on rate change. This should
> improve generated clock output stability. I currently have no scope at hand
> to actually test that properly, so there may be more issues remaining.
> 
> @Michael, Jean-Francois: Please test and report if there are still
> issues remaining.

I applied the patches 2 and 3, and the audio and video in the Cubox
work fine again. Thanks.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
