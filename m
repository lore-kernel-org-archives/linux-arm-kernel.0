From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 14 Sep 2011 16:59:17 -0600 (MDT)
Subject: OMAP2+: hwmod: remove OMAP_CHIP*
In-Reply-To: <alpine.DEB.2.00.1109051606330.19606@esdhcp041196.research.nokia.com>
References: <alpine.DEB.2.00.1109042042250.9056@utopia.booyaka.com>
	<alpine.DEB.2.00.1109051606330.19606@esdhcp041196.research.nokia.com>
Message-ID: <alpine.DEB.2.00.1109141655370.15220@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Aaro,

On Tue, 6 Sep 2011, Aaro Koskinen wrote:

> Should the timer12 be also removed from the common omap3xxx_hwmods
> list, as it is not available on (some?) HS devices. See
> e.g. <http://marc.info/?l=linux-omap&m=129433066521102&w=2>
> 
> Currently RM-680 boot is broken because of this.

Hmmm.  I guess the software that boots the HS devices can pick and choose 
which of the secure devices to make available to Linux.  So I guess that 
on HS/EMU devices, we'd have to assume that all of the HS devices (e.g. 
GPT12) are unavailable?

Does that approach make sense?

If so, maybe we can add a fix patch on top of these cleanup patches that 
handles that...


- Paul
