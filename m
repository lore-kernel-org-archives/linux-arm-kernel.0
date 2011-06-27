From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 27 Jun 2011 00:34:11 -0600 (MDT)
Subject: [PATCH 4/8] OMAP2+: PM: idle clkdms only if already in idle
In-Reply-To: <4DF1FE6A.3010202@ti.com>
References: <1307616853-28395-1-git-send-email-rnayak@ti.com>
	<1307616853-28395-2-git-send-email-rnayak@ti.com>
	<1307616853-28395-3-git-send-email-rnayak@ti.com>
	<1307616853-28395-4-git-send-email-rnayak@ti.com>
	<1307616853-28395-5-git-send-email-rnayak@ti.com>
	<20110610001556.GA9159@google.com> <4DF1FE6A.3010202@ti.com>
Message-ID: <alpine.DEB.2.00.1106270012410.460@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rajendra, Todd,

On Fri, 10 Jun 2011, Rajendra Nayak wrote:

> Paul/Benoit any thoughts on if a per-clkdm lock seems reasonable?

Sounds okay to me.

The experimental patch that you sent didn't add the locking to the *wkdep, 
*sleepdep functions; I guess we'd better add it there at the same time, 
since some of the register access there does a read-modify-write.

It should be possible to get rid of the atomic_t usage in the clockdomain 
code as part of the same series.

Todd, thanks for pointing this out.


- Paul
