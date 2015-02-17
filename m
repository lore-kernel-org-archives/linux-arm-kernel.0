From: joshua.clayton@uniwest.com (Joshua Clayton)
Date: Tue, 17 Feb 2015 09:51:05 -0800
Subject: [PATCH] i.MX6: WEIM: put node reference on early loop exit
In-Reply-To: <60BA5429A0E1584BA3633194F6F993B5576E8DB6@NA-MBX-03.mgc.mentorg.com>
References: <1423848784-6988-1-git-send-email-alison_chaiken@mentor.com>
 <20150216054702.GF12209@pengutronix.de>
 <60BA5429A0E1584BA3633194F6F993B5576E8DB6@NA-MBX-03.mgc.mentorg.com>
Message-ID: <21911320.10lVZQzK19@jclayton-pc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, February 17, 2015 04:28:28 PM Chaiken, Alison wrote:
> Sascha Hauer <s.hauer@pengutronix.de>
> 
> >Looking at the code I get the question why the current code bails out on
> >error. Wouldn't it be better to just skip erroneous child devices and
> >issue a warning?
> 
> The WEIM connects only one child at any given time.   Since it is a platform
Not true. WEIM is designed to connect to up to 4 children each with its own 
chipselect and io memory area.

> device, any child is cold-plugged.   If the probe of the child that is
> marked 'status = "okay"' in the device-tree fails, then the WEIM itself has
> no function, which sounds more like an error than a warning state.
Is it possible to set 'status = disabled' per child if the call to 
weim_timing_setup() fails, or something like that, so that 
of_platform_populate() will skip it? 

> 
> -- Alison
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Joshua Clayton
Software Engineer
UniWest
122 S. 4th Avenue
Pasco, WA 99301
Ph: (509) 544-0720
Fx: (509) 544-0868 
