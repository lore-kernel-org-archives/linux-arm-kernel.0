From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Thu, 3 May 2012 19:25:36 +0000
Subject: [PATCH] net: davinci_emac: Add pre_open, post_stop platform
 callbacks
In-Reply-To: <20120503184632.GA28089@animalcreek.com>
References: <20120502234718.GA5432@animalcreek.com>
 <B5906170F1614E41A8A28DE3B8D121433EA72820@DBDE01.ent.ti.com>
 <20120503160917.GA11310@animalcreek.com>
 <B5906170F1614E41A8A28DE3B8D121433EA73591@DBDE01.ent.ti.com>
 <20120503184632.GA28089@animalcreek.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EA7366B@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2012 at 00:16:32, Mark A. Greer wrote:
[...]
> > 
> > So, if I understood this correctly, it's effectively like blocking a low power
> > state transition (here wfi execution) when EMAC is active?
> 
> Assuming "it" is my patch, correct.
> 

Recently I was thinking about how to get certain drivers to disallow some or all
low power states and to me this also seems to fall in a similar category.

One of the suggestions that I got was to check if the 'wakeup' entry associated with
the device under sysfs could be leveraged for this. The PM code could maintain
a whitelist (or blacklist) of devices and it decides the low power state to enter
based on the 'wakeup' entries associated with these devices. In this particular case,
maybe the driver could simply set this entry to non-wakeup capable when necessary and
then let the PM code take care of skipping the wfi execution.

Thoughts/brickbats welcome :)

Regards,
Vaibhav
