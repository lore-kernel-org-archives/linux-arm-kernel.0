From: tony@atomide.com (Tony Lindgren)
Date: Fri, 17 Feb 2012 13:23:18 -0800
Subject: [PATCH 0/3] omap hsmmc init cleanup and section warning fixes
 for v3.4 merge window
In-Reply-To: <20120217091433.GL15338@n2100.arm.linux.org.uk>
References: <20120215182355.18884.18682.stgit@kaulin.local>
 <CACYZBRE_Vf8qDQYPRgsL03T8oy2Kv4fYRfE8U7y79Xhb1nwC2A@mail.gmail.com>
 <20120216121234.GJ15338@n2100.arm.linux.org.uk>
 <4F3CF7D1.8050807@ti.com> <4F3D0186.2010500@ti.com>
 <20120216135151.GK15338@n2100.arm.linux.org.uk>
 <20120217091433.GL15338@n2100.arm.linux.org.uk>
Message-ID: <20120217212318.GG18185@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120217 00:43]:
> 
> Tony: I think there's a bug here - if the gpio-twl4030 module is inserted,
> removed and re-inserted, I think we'll end up creating the devices for MMC
> twice with the same name, resulting in sysfs complaining very loudly.

I guess you mean without splitting omap2_hsmmc_init() into two functions.
Yup that's a nasty surprise that should be fixed for the -rc series.

Regards,

Tony
