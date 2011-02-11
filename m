From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 10 Feb 2011 22:14:21 -0700 (MST)
Subject: [PATCH 3/3] OMAP4: clockdomain: Add wkup/sleep dependency support
In-Reply-To: <74b7dfbe67e19da4358f7df0bc4dd8f1@mail.gmail.com>
References: <1297084631-27474-1-git-send-email-rnayak@ti.com>
	<1297084631-27474-2-git-send-email-rnayak@ti.com>
	<1297084631-27474-3-git-send-email-rnayak@ti.com>
	<1297084631-27474-4-git-send-email-rnayak@ti.com>
	<alpine.DEB.2.00.1102101905160.21991@utopia.booyaka.com>
	<3754d10e94217aa81846aa1d41fe0a9d@mail.gmail.com>
	<alpine.DEB.2.00.1102102135220.21991@utopia.booyaka.com>
	<74b7dfbe67e19da4358f7df0bc4dd8f1@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1102102209080.21991@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rajendra

On Fri, 11 Feb 2011, Rajendra Nayak wrote:

> Failing silently is going to make it more difficult to identify and fix. 
> Maybe a WARN in else?
> 
> 	if (cd->clkdm) {
> 		...
> 	} else
> 		WARN()

I was thinking it might be nice to put it right next to the 
_clkdm_lookup()s in clkdm_init(), since the _clkdm_lookup is what is 
actually failing.  Then we could do a

if (!cd->clkdm)
	continue;

in the SoC-specific *_all_wkdep/sleepdep* code, just to keep the system 
from crashing...

Does that sound okay to you?


- Paul
