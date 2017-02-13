From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 13 Feb 2017 10:52:07 +0100
Subject: Allwinner A31 framebuffer fails with new CCU clock bindings
In-Reply-To: <1486814920.7145.19.camel@settrans.net>
References: <1486814920.7145.19.camel@settrans.net>
Message-ID: <20170213095207.tsqcigfhyftm5ohk@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Feb 11, 2017 at 12:08:40PM +0000, Bob Ham wrote:
> Hi there,
> 
> I have a Mele A1000G Quad top set box with an Allwinner A31 chip.
> Unfortunately, the framebuffer is failing on recent kernels.  I have a
> 1080p monitor connected to the HDMI output.  During boot, the monitor
> goes blank and reports "No Signal".
> 
> I've done a git bisect and determined that this is the offending commit:
> 
> # first bad commit: [78a9f0dbcd6015cdd1114dc7d78554fd5bb28010] ARM: dts: sun6i: switch A31/A31s to new CCU clock bindings
> 
> 
> On IRC, MoeIcenowy requested the contents
> of /sys/kernel/debug/clk/clk_summary.  I don't know how useful it will
> be but I've put up two versions, one from the bad commit and another
> from the previous, good commit in the bisect:
> 
> http://settrans.net/~rah/misc/sun6i-a31-bad-fb-clk_summary-good.txt
> http://settrans.net/~rah/misc/sun6i-a31-bad-fb-clk_summary-bad.txt

Are you sure the good one works? None of the display clocks are
enabled.

Could you add "clk_ignore_unused" to the kernel boot parameters and
see if it works?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170213/030fb381/attachment.sig>
