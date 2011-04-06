From: saeed.bishara@gmail.com (saeed bishara)
Date: Wed, 6 Apr 2011 11:22:51 +0300
Subject: [PATCH] Moving Marvell Dove platform defaults to ARMv7
In-Reply-To: <alpine.LFD.2.00.1104051450550.28032@xanadu.home>
References: <1301814792-9438-1-git-send-email-kostap@marvell.com>
	<BANLkTimsz==SVdg0C6XEX6bCvmhEe79dew@mail.gmail.com>
	<alpine.LFD.2.00.1104051450550.28032@xanadu.home>
Message-ID: <BANLkTinJP1S_tUfTG8jeeZRTq80bCE8kvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 5, 2011 at 9:55 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Tue, 5 Apr 2011, saeed bishara wrote:
>
>> On Sun, Apr 3, 2011 at 10:13 AM, Konstantin Porotchkin
>> <kostap@marvell.com> wrote:
>> > Disabled legacy support for ARMv6 archtecture on Dove platform.
>> > Latest Dove HW uses only ARMv7 model.
>
> What about older Dove hardware? ?That's all I have for testing.
1. you can configure it to v7 mode by setting dip switch #6 of SW2 to off.
SW2 dip switch group is the middle one out of 3 that located near the DRAM DIMM.
2. but, we are going to drop support for the old boards when we add
mpp configuration, I'll check if we can send you new board.
>
>> > --- a/arch/arm/configs/dove_defconfig
>> > +++ b/arch/arm/configs/dove_defconfig
> [...]
>> > -# CONFIG_MISC_DEVICES is not set
>> > +CONFIG_LEGACY_PTY_COUNT=16
>> > -CONFIG_LEGACY_PTY_COUNT=16
>> > -# CONFIG_VGA_CONSOLE is not set
>> > -CONFIG_USB_EHCI_TT_NEWSCHED=y
>> > -CONFIG_INOTIFY=y
>> > -# CONFIG_RCU_CPU_STALL_DETECTOR is not set
>> > -CONFIG_CRYPTO_CBC=y
>> > -CONFIG_CRYPTO_MD5=y
>> > -CONFIG_CRYPTO_DES=y
>
> Those changes above are unrelated to the reason for this patch. ?Please
> remove.
should we prepare a separate patch that syncs the dove_defconfig with
latest kernel?

>
>
> Nicolas
>
