From: balbi@ti.com (Felipe Balbi)
Date: Mon, 22 Nov 2010 12:08:15 +0200
Subject: [PATCH v3 2/5] OMAP: mailbox: fix rx interrupt disable in omap4
In-Reply-To: <4CE68E9A.5040903@ti.com>
References: <1290107742-16760-1-git-send-email-h-kanigeri2@ti.com>
	<1290107742-16760-3-git-send-email-h-kanigeri2@ti.com>
	<4CE5B68F.8000502@ti.com>
	<AANLkTinVOKZoSRkXyfzUap5mOmRE5nNsvCiw_QDUxb85@mail.gmail.com>
	<20101119083250.GH6446@legolas.emea.dhcp.ti.com>
	<AANLkTimzaB6aFo2=iEpR=2a3T_3oWQa6iBxQxWhBBCiw@mail.gmail.com>
	<4CE68E9A.5040903@ti.com>
Message-ID: <20101122100815.GM2446@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 19, 2010 at 03:50:02PM +0100, Cousson, Benoit wrote:
>Most of the time, we do not want to use the IP revision because it is 
>un-accurate and does not reflect the change we'd like to track.
>For example some time a minor change in the RTL that will not impact 
>the SW at all might trigger a change in the IP revision, whereas on 
>the other hand a major bug fix that will impact the SW is not capture 
>in the IP revision... yeah, that's bad, but this can happen.
>
>That's why we are relying on a rev field in the hwmod.

But then, what's inside this rev field ? Is it some internal revision of
hwmod or do you read from the hw ?

-- 
balbi
