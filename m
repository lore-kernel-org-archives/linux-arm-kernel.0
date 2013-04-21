From: tim@krieglstein.org (Tim Sander)
Date: Sun, 21 Apr 2013 11:43:50 +0200
Subject: Pinmuxing with devicetree (beaglebone)
Message-ID: <201304211143.50961.tim@krieglstein.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

I am currently trying to get pinmuxing working on a beaglebone board with an 
offtree driver. This is for a custom handbuild hardware so i guess there is no 
point in bringing this mainline.

While this is havyly patched 3.8.4 version running over here i think the
pinmux infrastructure is the new standard way. At least there is a 
pinctrl/44e10800.pinmux directory in debugfs?

My last aproach was using the devicetree but beeing new to this devicetree 
stuff i just got stuck: 
http://comments.gmane.org/gmane.linux.ports.arm.kernel/231204

Now i tried use the way it is described in Documentation/pinctrl.txt but still 
there are the includes missing: #include <linux/pinctrl/consumer.h>.

Also while there is a /sys/kernel/debug/pinctrl/44e10800.pinmux in debugfs i 
found that not so intuitive as the omap_mux which disappeared. Also i didn't 
find any documentation for this debugfs stuff.

So what is the recommended way to get this stupid pinmuxing going. In pre 
devicetree days one would just pick the mux.h include of the platform and 
initialized the muxers which was pretty straight forward. Now with device tree 
its much more complicated. No proper syntax checking as with the c definitions 
and no documentation how to get this magic stuff working :-(.

The whole stuff is build by a ptxdist (a embedded buildsystem) and can be 
found over here:
https://gitorious.org/ptxdist-beaglebone/ptxdist-beaglebone

Best regards
Tim
