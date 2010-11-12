From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 12 Nov 2010 12:50:05 -0500 (EST)
Subject: [PATCH 10/11] ARM: pxa: add 32KHz timer as clock source
In-Reply-To: <1289546260-6208-10-git-send-email-haojian.zhuang@marvell.com>
References: <1289546260-6208-1-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-2-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-3-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-4-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-5-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-6-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-7-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-8-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-9-git-send-email-haojian.zhuang@marvell.com>
	<1289546260-6208-10-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <alpine.LFD.2.00.1011121246000.13911@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 12 Nov 2010, Haojian Zhuang wrote:

> PXA silicons are using 3MHz timer as default clock source. But it'll be stopped
> counting in low power mode. Although 32KHz timer is slow, it can continue
> counting in low power mode. While low power mode is implemented as idle,
> stopped timer can't be accepted.
> 
> Add 32KHz timer as an alternative clock source. User can switch clock source
> on demand.

Why are you doing this?  What's wrong with  having timers stopped when 
in sleep mode?  I don't think a 32K timer is precise enough for 
runtime usage in general.

What you should do instead is to use the 32KHz timer to readjust OSCR 
when the CPU comes out of sleep mode.


Nicolas
