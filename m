From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 30 May 2014 07:10:58 +0200
Subject: [PATCH v11 0/3] Exynos 5410 support
In-Reply-To: <538775AB.3000604@suse.de>
References: <1401074613-29227-1-git-send-email-t.dakhran@samsung.com>
 <7hr43f9mmn.fsf@paris.lan> <538737CA.4070709@suse.de>
 <53874862.5080809@samsung.com> <538775AB.3000604@suse.de>
Message-ID: <538812E2.6070807@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andreas,

On 29.05.2014 20:00, Andreas F?rber wrote:

[snip]

> Some of the low-hanging fruit like no heartbeat/SD LEDs, no RTC, no
> usb3503 and thus no network I'm already looking into myself. For now I'm
> putting everything into the SMDK .dts, but I guess we'll need to split
> off -odroidxu.dts and -pinctrl.dtsi at some point.

Odroid XU needs its own dts for sure. I think you can make a copy of
SMDK dts and name it -odroidxu straightaway and work further with it.

exynos5410-pinctrl.dtsi is used for generic SoC-wide pinctrl
definitions, such as pin banks and pin groups. There should be no
board-specific things defined in it. Instead respective board dts should
have them.

> 
> What about graphics? The 5410 is an oddball in using PowerVR rather than
> Mali GPU - should a framebuffer on HDMI or DisplayPort work if we add DT
> nodes, or will the GPU require larger code changes?

The 3D GPU is completely independent from display controllers, which are
standard Samsung IP blocks, so you should be able to get unaccelerated
output using VP+Mixer+HDMI or FIMD+DP using existing drivers.

Best regards,
Tomasz
