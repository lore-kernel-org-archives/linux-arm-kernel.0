From: balbi@ti.com (Felipe Balbi)
Date: Tue, 23 Nov 2010 10:10:48 +0200
Subject: [PATCH v3 2/5] OMAP: mailbox: fix rx interrupt disable in omap4
In-Reply-To: <4CEA8473.3040404@ti.com>
References: <1290107742-16760-1-git-send-email-h-kanigeri2@ti.com>
	<1290107742-16760-3-git-send-email-h-kanigeri2@ti.com>
	<4CE5B68F.8000502@ti.com>
	<AANLkTinVOKZoSRkXyfzUap5mOmRE5nNsvCiw_QDUxb85@mail.gmail.com>
	<20101119083250.GH6446@legolas.emea.dhcp.ti.com>
	<AANLkTimzaB6aFo2=iEpR=2a3T_3oWQa6iBxQxWhBBCiw@mail.gmail.com>
	<4CE68E9A.5040903@ti.com>
	<20101122100815.GM2446@legolas.emea.dhcp.ti.com>
	<4CEA8473.3040404@ti.com>
Message-ID: <20101123081048.GJ2729@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 22, 2010 at 03:55:47PM +0100, Cousson, Benoit wrote:
>So far we are using a artificial SW IP revision that reflect the 
>difference we'd like to highlight v1, v2.

but what's the big deal in reading that from HW itself ? The only change
will in the comparisson operator. Instead of doing:

if (rev == REV_V1)

you'll be doing:

if (rev >= REV_V1_X_Y_Z)

no ??

-- 
balbi
