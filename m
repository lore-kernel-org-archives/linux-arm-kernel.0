From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 16 Mar 2016 10:26:08 -0500
Subject: [PATCH] Revert "arm64: Increase the max granular size"
In-Reply-To: <20160316141802.GC13423@e104818-lin.cambridge.arm.com>
References: <1458120743-12145-1-git-send-email-opensource.ganesh@gmail.com>
 <20160316100759.GA18387@arm.com> <56E95A4E.4050709@codeaurora.org>
 <20160316141802.GC13423@e104818-lin.cambridge.arm.com>
Message-ID: <56E97B10.4050401@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas wrote:
> Why do you need your own defconfig? If it's just on the short term until
> all your code is upstream, that's fine, but this goes against the single
> Image aim. I would like defconfig to cover all supported SoCs (and yes,
> ACPI on by default once we deem it !EXPERT anymore), though at some
> point we may need a server/mobile split (if the generated image is too
> large, maybe more stuff being built as modules).

Yes, that's exactly it.  Ours is an ACPI system, and so we have to have 
our own defconfig for now.  We're holding off on pushing our own 
defconfig changes (enabling drivers, etc) until ACPI is enabled in 
arch/arm64/configs/defconfig.

My understanding is that ACPI won't be enabled by default until at least 
after the GIC driver is fully ACPI-enabled.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation collaborative project.
