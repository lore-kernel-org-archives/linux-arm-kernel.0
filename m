From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Wed, 8 Aug 2012 16:34:15 +0000
Subject: [PATCH 1/1] ARM: OMAP2+: hwmod: Print an error message if no
 match exists for a hwmod class
In-Reply-To: <alpine.DEB.2.00.1208080803560.5447@utopia.booyaka.com>
References: <1344422117-20707-1-git-send-email-vaibhav.bedia@ti.com>
 <alpine.DEB.2.00.1208080803560.5447@utopia.booyaka.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EB32ABA@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Wed, Aug 08, 2012 at 19:35:50, Paul Walmsley wrote:
[...]
> It doesn't seem to me that this would necessarily always be an error.  
> Suppose some init code to create cpsw devices is running on an OMAP3430.  
> Then a omap_hwmod_for_each_by_class() that doesn't locate anything 
> wouldn't be an error, right?
> 

Well, I think a failed lookup operation will be a bit expensive since it
iterates over the whole list of registered hwmods and hence put in the
pr_err(). But I don't see how the SoC specific example that you pointed out
could be handled without putting in cpu_is_* checks in the registration
process itself :(

Would a pr_debug() be ok?

Regards,
Vaibhav B.
