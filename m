From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 8 Apr 2011 09:31:10 +0200
Subject: 2.6.39-rc2 on zaurus: does not build, does not boot
In-Reply-To: <20110408062646.GA1472@ucw.cz>
References: <20110408062646.GA1472@ucw.cz>
Message-ID: <201104080931.11202.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 April 2011 08:26:46 Pavel Machek wrote:
> Hi!
> 
> Build fix is below. Maybe it is pending in the trees somewhere
> already...

Fix is already there, it was broken by a patch from someone recently. Thanks 
though
> 
> Boot stops just after mounting root filesystem; cursor stops
> flashing. (Any idea what goes on there?)

No idea, it works for me and doesn't hang ;-)

> 
> 								Pavel
> 
> --- ./drivers/video.ofic/pxafb.c	2011-04-06 15:19:51.000000000 +0200
> +++ ./drivers/video/pxafb.c	2011-04-07 06:20:20.000000000 +0200
> @@ -1648,7 +1648,7 @@
> 
>  	switch (val) {
>  	case CPUFREQ_PRECHANGE:
> -		if (!fbi->overlay[0].usage && !fbi->overlay[1].usage)
> +//		if (!fbi->overlay[0].usage && !fbi->overlay[1].usage)
>  			set_ctrlr_state(fbi, C_DISABLE_CLKCHANGE);
>  		break;
