From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Dec 2017 10:58:01 +0000
Subject: [PATCH 4/7 v2] net: ethernet: i825xx: Fix platform_get_irq's
 error checking
In-Reply-To: <791fdb7d-e0ec-eefb-c703-205c039eddc3@cogentembedded.com>
References: <1512409703-20881-1-git-send-email-arvind.yadav.cs@gmail.com>
 <1512409703-20881-5-git-send-email-arvind.yadav.cs@gmail.com>
 <20171204.132556.1601454745789376393.davem@davemloft.net>
 <791fdb7d-e0ec-eefb-c703-205c039eddc3@cogentembedded.com>
Message-ID: <20171205105801.GV10595@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 05, 2017 at 01:12:23PM +0300, Sergei Shtylyov wrote:
>    Well, we can have:
> 
> 	return r && r->start ? r->start : -ENXIO;
> 
> instead of:
> 
> 	return r ? r->start : -ENXIO;
> 
> at the end of platform_get_irq(). But I don't really think it's worth doing
> -- request_irq() doesn't filter out IRQ0 anyway, IIRC...

There's a bunch of platforms in the kernel that still use IRQ0, and
have done prior to Linus' comments on the subject.  Such a change
would regress them.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
