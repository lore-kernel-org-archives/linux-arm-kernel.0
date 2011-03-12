From: eric.y.miao@gmail.com (Eric Miao)
Date: Sat, 12 Mar 2011 10:29:17 +0800
Subject: [PATCH 5/8] ARM: PXA: Z2: Add poweroff function
In-Reply-To: <201103120105.15474.marek.vasut@gmail.com>
References: <1299839023-16601-1-git-send-email-anarsoul@gmail.com>
	<201103112316.57914.marek.vasut@gmail.com>
	<201103120030.08986.anarsoul@gmail.com>
	<201103120105.15474.marek.vasut@gmail.com>
Message-ID: <AANLkTinEtNKzLK=NXJNqfzPU-KKtOjB5KKdV2KRX22i2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> No need, I understand how it works, PSPR is null, so after u-boot loads
>> PSPR to pc it performs 'soft reset' (jumps to 0x0, to begin of NOR flash),
>> RCSR bits are already cleared, so it just boots kernel.
>
> The note in Table 18 -- Exit from sleep or deep-sleep doesn't clear or set this
> bit -- means PSPR might not be null if you use your deep-sleep-parapowerdown.

PSPR is preserved during sleep/deep-sleep. Yet the actual implemention
of deep-sleep depends on the boot-loader.

The resume process is basically same as software reboot, and the BootROM
is supposed to load the bootloader instead of resuming from PSPR since the
RAM content is not preserved.
