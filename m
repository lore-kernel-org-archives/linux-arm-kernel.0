From: r-woodruff2@ti.com (Woodruff, Richard)
Date: Sun, 2 Jan 2011 08:28:41 -0600
Subject: [PATCH v6 07/10] OMAP3: PM: Adding T2 enabling of smartreflex
	support
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0373BA283D@dbde02.ent.ti.com>
References: <1292864357-13939-1-git-send-email-thara@ti.com>
	<1292864357-13939-8-git-send-email-thara@ti.com>
	<87mxnxr1n8.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0373BA283D@dbde02.ent.ti.com>
Message-ID: <13B9B4C6EF24D648824FF11BE896716203EAA39DD0@dlee02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of Gopinath, Thara
> Sent: Friday, December 31, 2010 2:02 AM

> >>Is this true for OMAP2 as well?

OMAP2 used VSEL for direct and VMODE for voltage control not SR path methods. I don't recall OMAP2 ever need to enable this as that path is not hooked up.  I've not double checked details but that is recollection.

> >>This patch actually hangs the boot on 2430SDP.

There were a lot of versions of 2430SDP boards PMIC-boards which created a variety of issues of someone is really watching the details.

Issues which stopped booting as I recall in the past were:
        - Initial state of interrupts not good allowing boot to livelock
        - Old boards had poor power routing and min voltages needed to be higher.
        - General i2c service thread issues.

I'd guess Thara has some random board with issues and Kevin's system is newer.  Probably Kevin is seeing patch issue as SR doesn't seem to follow for OMAP2.

Regards,
Richard W.
