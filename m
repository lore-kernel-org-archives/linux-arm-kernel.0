From: ipaton0@gmail.com (Iain Paton)
Date: Thu, 26 Mar 2015 16:58:55 +0000
Subject: [linux-sunxi] Re: [PATCH 1/2] ARM: dts: sun4i: a10-lime: Override
 and remove 1008MHz OPP setting
In-Reply-To: <20150319085716.75d3ce76@i7>
References: <1426732773-7179-1-git-send-email-wens@csie.org>
 <1426732773-7179-2-git-send-email-wens@csie.org> <20150319085716.75d3ce76@i7>
Message-ID: <55143ACF.9070800@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/03/15 06:57, Siarhei Siamashka wrote:

> I should also mention that using 960MHz @1.4V does not fail, but it does
> not have any safety headroom either (the cyan 'sun4i_poorlime' line
> on the plot):
> 
>     http://people.freedesktop.org/~siamashka/files/20140512/sunxi-cpufreq-plot.png
> 
> On the other hand, my board is on the worst part of the spectrum (many
> other a10-lime boards do not fail even at 1008MHz), so maybe having
> extra safety headroom is less necessary.
> 
> An interesting question is whether the same problem may be reproducible
> on the Allwinner A10 devices other than A10-OLinuXino-LIME. My original
> problem report
> 
>     https://www.mail-archive.com/linux-sunxi at googlegroups.com/msg04343.html
>     
> mentioned the A10-OLinuXino-LIME rev.A and introduced some sort of
> a bias by itself. At least I have seen people saying something like
> "my a10-lime revision is not rev.A, so it's none of my concern and
> I'm not going to bother running any tests". So far we have accumulated
> reports from 4 or 5 people having this reliability problem on their
> A10-OLinuXino-LIME (various revisions, not just rev.A), but not
> much from the other boards owners.

I'm somewhat sad to see 1008MHz go. I have 2x revA A10-Lime boards that 
are stable at 1008MHz with Maximes sunxi/for-next, a full regulator 
description in the dts and a very recent u-boot. They are not stable at 
1056 or above however.


Can I ask what the basis is for the 960MHz setting?  I don't see any 
instances of it in any of the a10 fex files, meaning it's likely not 
very well tested.

If there's interest, I'll send the patch adding regulators to the dts for 
the a10-lime.

Rgds,
Iain
