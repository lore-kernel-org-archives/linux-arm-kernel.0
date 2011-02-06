From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 6 Feb 2011 13:42:23 -0700 (MST)
Subject: [PATCH v2 1/9] omap4: powerdomain: Add supported INACTIVE power
	state
In-Reply-To: <1296813544-25170-2-git-send-email-santosh.shilimkar@ti.com>
References: <1296813544-25170-1-git-send-email-santosh.shilimkar@ti.com>
	<1296813544-25170-2-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <alpine.DEB.2.00.1102061335400.7672@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Fri, 4 Feb 2011, Santosh Shilimkar wrote:

> On OMAP4, one can explicitly program INACTIVE as the power state of
> the logic area inside the power domain. Techincally PD state programmed
> to ON and if all the clock domains within the PD are idled, is equivalent
> tp PD programmed to INACTIVE and all the clock domains within the PD are
> idled. There won't be any power difference in above two.
> 
> This patch adds the support to allow power domain INACTIVE programming
> which is supported on OMAP4.
> 
> The powerdomain autogen script is updated accordingly.

Continuing the discussion here:

   http://www.mail-archive.com/linux-omap at vger.kernel.org/msg43509.html

1. It appears that the OMAP4 powerdomain ON-ACTIVE state is a new state 
for OMAP4, and does not exist as such on previous chips (unless the 
PRM_VOLTCTRL.AUTO_* bits are all disabled)

2. It also appears that the OMAP4 powerdomain ON-INACTIVE state 
is equivalent to the OMAP3 powerdomain ON state (again, assuming that the 
PRM_VOLTCTRL.AUTO_SLEEP bit is set on OMAP3).

Could you please comment on whether these statements are true or false?


- Paul
