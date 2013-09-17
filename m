From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 17 Sep 2013 20:03:01 +0200
Subject: [PATCH] arm: Kirkwood - Remove kirkwood_setup_wins and rely on
 the DT binding
In-Reply-To: <20130917153619.GA14098@obsidianresearch.com>
References: <20130916224743.GA18349@obsidianresearch.com>
 <20130917133206.GB2488@localhost>
 <20130917153619.GA14098@obsidianresearch.com>
Message-ID: <20130917200301.66e8ccb9@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

On Tue, 17 Sep 2013 09:36:19 -0600, Jason Gunthorpe wrote:

> Since they are all the same I'll respin the patch and add the ranges
> to the kirkwood.dtsi and remove it from all the board files, (which is
> where I started, but then saw that board files had a ranges
> already)

In Armada 370/XP land, we've decided to always put the ranges in the
per-board .dts file. The reason is that sometimes, a board needs to add
an additional range (like for a NOR device for example), and
unfortunately, the existing DT language doesn't allow "extending"
a 'ranges' property defined at the .dtsi level by an additional entry
added at the .dts level.

This has lead to problems in Armada 370/XP land, where we were
overloading the ranges property for some boards in the .dts, then added
a new range in the .dtsi, and forgot to propagate this change to
the .dts files. To avoid this, we've decided to have the ranges
property always in the .dts files.

A better solution would be to have a += operator in the DT language,
but until that exists, we thought that pushing the ranges property down
to the .dts file was the least horrible solution.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
