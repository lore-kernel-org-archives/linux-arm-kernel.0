From: apinski@caviumnetworks.com (Andrew Pinski)
Date: Thu, 17 Mar 2016 11:07:00 -0700
Subject: [PATCH] Revert "arm64: Increase the max granular size"
In-Reply-To: <20160317142716.GC11623@e104818-lin.cambridge.arm.com>
References: <1458120743-12145-1-git-send-email-opensource.ganesh@gmail.com>
 <20160316100759.GA18387@arm.com> <56E95A4E.4050709@codeaurora.org>
 <20160316141802.GC13423@e104818-lin.cambridge.arm.com>
 <56E97B10.4050401@codeaurora.org>
 <20160317142716.GC11623@e104818-lin.cambridge.arm.com>
Message-ID: <56EAF244.2090805@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/17/2016 7:27 AM, Catalin Marinas wrote:
> On Wed, Mar 16, 2016 at 10:26:08AM -0500, Timur Tabi wrote:
>> Catalin Marinas wrote:
>>> Why do you need your own defconfig? If it's just on the short term until
>>> all your code is upstream, that's fine, but this goes against the single
>>> Image aim. I would like defconfig to cover all supported SoCs (and yes,
>>> ACPI on by default once we deem it !EXPERT anymore), though at some
>>> point we may need a server/mobile split (if the generated image is too
>>> large, maybe more stuff being built as modules).
>> Yes, that's exactly it.  Ours is an ACPI system, and so we have to have our
>> own defconfig for now.  We're holding off on pushing our own defconfig
>> changes (enabling drivers, etc) until ACPI is enabled in
>> arch/arm64/configs/defconfig.
> Is there anything that prevents you from providing a dtb/dts for this
> SoC?

Note ThunderX's SOC have customers  where some are embedded users 
(uboot) and server users (UEFI).  The cores always have 128 byte 
cacheline size.  So please don't make this dependent on ACPI.  Note the 
defconfig works correctly on T88.

Thanks,
Andrew


>
