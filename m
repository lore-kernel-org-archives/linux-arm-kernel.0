From: tjakobi@math.uni-bielefeld.de (Tobias Jakobi)
Date: Tue, 24 Feb 2015 13:22:41 +0100
Subject: [PATCHv3 0/8] devfreq: Add generic exynos memory-bus
 frequency driver
In-Reply-To: <473523680.35451424740978095.JavaMail.weblogic@epmlwas05a>
References: <473523680.35451424740978095.JavaMail.weblogic@epmlwas05a>
Message-ID: <3d11219e3af0d964bd6396c6be320276@math.uni-bielefeld.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello MyungJoo!

On 2015-02-24 02:22, MyungJoo Ham wrote:
> Unless you are willing to wait for 2 minutes after the kernal hangs,
> you may want to adjust "DEFAULT_HUNG_TASK_TIMEOUT" to shorter value
> (120 --> 5 for 5 seconds). It seems that you've cut it off in the 
> middle
> of that "120 sec" wait.
Thanks for the hint! Yes, I should probably adjust this value when
doing more tests.


> If it's in D state (in kernel), gdb won't work as you are experiencing.
> Sorry for not testing with HDMI; my Exynos devices do not have HDMI. :)
Well, like I said above, the HDMI doesn't seen to be affected by the low
MIF/INT clocks. I have tested this with 1280x720 here on my Odroid X2,
but I also have another user (with a U3 if I remember correctly) who
also confirms that HDMI is working in combination with devfreq and
simple_ondemand.

I guess it's just the G2D engine that doesn't like the low clocks. Maybe
it also affects the IPP subsystem, but I have no means to test this.


With best wishes,
Tobias
