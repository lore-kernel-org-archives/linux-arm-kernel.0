From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 17 Sep 2013 20:58:09 +0200
Subject: [PATCH] arm: Kirkwood - Remove kirkwood_setup_wins and rely on
 the DT binding
In-Reply-To: <20130917181742.GA4182@obsidianresearch.com>
References: <20130916224743.GA18349@obsidianresearch.com>
 <20130917133206.GB2488@localhost>
 <20130917153619.GA14098@obsidianresearch.com>
 <20130917200301.66e8ccb9@skate>
 <20130917181742.GA4182@obsidianresearch.com>
Message-ID: <20130917205809.6e883b13@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

On Tue, 17 Sep 2013 12:17:42 -0600, Jason Gunthorpe wrote:

> Yes, I recall you talking about this, that is why initially just went
> adding to the existing mbus ranges in the board files.
> 
> However, is that really still the case? Now that PEX uses a difference
> scheme it seems they all washed out to be the same.

No, some boards have a NOR flash that requires a dedicated window, some
do not have a NOR flash.

> > but until that exists, we thought that pushing the ranges property down
> > to the .dts file was the least horrible solution.
> 
> I think we can get away with doing it the other way for kirkwood,
> here are my reasons:
>  - Kirkwood is mature now, the DT is basically complete, we shouldn't
>    need to churn the ranges in the dtsi much, if at all.
>  - There are 31 kirkwood dts files, and none of them need a ranges
>    different from the default
>  - Kirkwood has more than enough mbus windows, we don't need to be
>    stingy with them
>  - The board files were already sort of like this, but a big chunk
>    of the 31 boards were missing ranges entirely.
> 
> Basically, no board file has a ranges, only the kirkwood.dtsi has a
> ranges.

Right, true that for Kirkwood this probably stands.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
