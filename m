From: embed3d@gmail.com (Philipp Rossak)
Date: Mon, 12 Feb 2018 19:21:40 +0100
Subject: BUG: A31s Not booting anymore
Message-ID: <e155f7fc-9c22-d8ac-d142-805812aa9988@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey,

When I try to boot my A31s (Bananapi M2) u-boot is showing only Starting 
kernel ... . After enabling the earlyprintk I could capture this log: [1].

After reverting those 5 commits from Chen-Yu I was able to boot again:


clk: sunxi-ng: Support fixed post-dividers on NM style clocks
7d333ef1cc1b8c8951f3a2c41f6406e2295d8be9

clk: sunxi-ng: sun8i: a83t: Add /2 fixed post divider to audio PLL
10e6eb4f2c5b35ae71c9bc0db83d74238719b453

clk: sunxi-ng: sun8i: a83t: Use sigma-delta modulation for audio PLL
e952ca3c6b2ffdfbf9618e4bd3e9aad1ff3f5eb4

clk: sunxi-ng: Support fixed post-dividers on MP style clocks
946797aa3f08e2f6f5992f3ec2be44791e9b9260

clk: sunxi-ng: sun50i: a64: Add 2x fixed post-divider to MMC module clocks
83fe3be4d1974f5f50c5e2039a1609f4960e8579


I allready tried to fix it with making them save against zero:

if (cmp->common.features & CCU_FEATURE_FIXED_POSTDIV && \
     	cmp->fixed_post_div with)
                rate *= cmp->fixed_post_div;

But that didn't help.

Any ideas?

Regards,
Philipp

[1]: https://pastebin.com/64Fzzqvg
