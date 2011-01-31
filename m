From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 31 Jan 2011 16:14:12 -0700 (MST)
Subject: [PATCH 1/6] omap4: powerdomain: Add supported INACTIVE power state
In-Reply-To: <1296212688-21951-2-git-send-email-santosh.shilimkar@ti.com>
References: <1296212688-21951-1-git-send-email-santosh.shilimkar@ti.com>
	<1296212688-21951-2-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <alpine.DEB.2.00.1101311613230.16671@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Santosh,

On Fri, 28 Jan 2011, Santosh Shilimkar wrote:

> On OMAP4, one can explicitly program INACTIVE as the power state of
> the logic area inside the power domain. Techincally PD state programmed
> to ON and if all the clock domains within the PD are idled, is equivalent
> tp PD programmed to INACTIVE and all the clock domains within the PD are
> idled. There won't be any power difference in above two.
> 
> Since the CPUIDLE C-states explicitly make use of INACTIVE as a PD
> targeted state and also there is some additional latancy involved
> with PD INACTIVE vs PD ON, it's better to support it as an explcit
> PD state.
> 
> This patch adds the support to allow explicit PD INACTIVE
> programming if supported.

What does the hardware do when the powerdomain is programmed to INACTIVE?  
Does it actually force the clockdomains idle?


- Paul
