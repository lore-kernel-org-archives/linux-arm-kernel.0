From: nm@ti.com (Nishanth Menon)
Date: Wed, 29 Feb 2012 16:53:12 -0600
Subject: [PATCH 04/13] ARM: OMAP3+: SmartReflex: Add a shutdown hook
In-Reply-To: <1330554829-11347-5-git-send-email-j-pihet@ti.com>
References: <1330554829-11347-1-git-send-email-j-pihet@ti.com>
 <1330554829-11347-5-git-send-email-j-pihet@ti.com>
Message-ID: <20120229225310.GA7400@kobold>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23:33-20120229, Jean Pihet wrote:
> From: Nishanth Menon <nm@ti.com>
> 
> SmartReflex fix for erratum ID i724.
> 
> Since OMAP's VP and PRM modules do not get reset by warm reset,
> we should ensure that proper shutdown procedure is followed prior
> to allowing the kernel to reboot back up.
> 
Considering [1], can we rephrase the following?
> Without this patch, Smartreflex module might be left active or
IMHO, the word "patch" is redundant :)
> system might be caught in an indeterminate sequence when reboot
when software controlled reboot is triggered
> is triggered, leaving the next reboot behavior to be unpredictable.

In the case of hardware controlled warm reset such as that by watchdog
timer, prevention of this scenario is not possible.


[..]
-- 
Regards,
Nishanth Menon
[1] http://marc.info/?l=linux-omap&m=133053887101828&w=2
