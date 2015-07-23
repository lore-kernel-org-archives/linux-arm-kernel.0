From: petr.cvek@tul.cz (Petr Cvek)
Date: Thu, 23 Jul 2015 02:15:54 +0200
Subject: [RFC] backlight: pwm: Handle EPROBE_DEFER while requesting the PWM
Message-ID: <55B0323A.8060202@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
It seems, that commit

	68feaca0b13e453aa14ee064c1736202b48b342f

blocks the "legacy" call to request a PWM chip from PXA27x architecture (pwm_pxa). Checking for EPROBE_DEFER (default return from devm_pwm_get if pwm is not found) causes jump over it. Older versions of kernel (tested on 3.13-rc7) and modified 4.2.0-rc1 (commented goto) works. 

My question is: Should I write patch modifying error checking path or rather migrate legacy PXA driver to new API (I can only test pwm_pxa and only on one specific device)? 

Petr Cvek
