From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 13 Mar 2013 10:14:22 +0000 (UTC)
Subject: [PATCH] ARM: OMAP3: hwmod data: keep MIDLEMODE in force-standby
 for musb
In-Reply-To: <1363031340-9382-1-git-send-email-notasas@gmail.com>
References: <1363031340-9382-1-git-send-email-notasas@gmail.com>
Message-ID: <alpine.DEB.2.00.1303131013270.32131@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Gra?vydas,

On Mon, 11 Mar 2013, Grazvydas Ignotas wrote:

> For some unknown reason, allowing hwmod to control MIDLEMODE causes
> core_pwrdm to not hit idle states for musb in DM3730 at least.
> I've verified that setting any MIDLEMODE value other than "force
> standby" before enabling the device causes subsequent suspend
> attempts to fail with core_pwrdm not entering idle states, even
> if the driver is unloaded and "force standby" is restored before
> suspend attempt. To recover from this, soft reset can be used, but
> that's not suitable solution for suspend.
> 
> Keeping the register set at force standby (reset value) makes it work
> and device still functions properly, as musb has driver-controlled
> OTG_FORCESTDBY register that controls MSTANDBY signal.
> Note that TI PSP kernels also have similar workarounds.
> 
> This patch also fixes HWMOD_SWSUP_MSTANDBY documentation to match the
> actual flag name.
> 
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>

Thanks for the good patch description and for making those changes.  
Queued for v3.9-rc.

- Paul
