From: olof@lixom.net (Olof Johansson)
Date: Sun, 20 Feb 2011 16:40:51 -0800
Subject: [PATCH v2 05/21] ARM: tegra: clock: Disable clocks left on by
	bootloader
In-Reply-To: <1298154371-5641-7-git-send-email-ccross@android.com>
References: <1298154371-5641-1-git-send-email-ccross@android.com>
	<1298154371-5641-7-git-send-email-ccross@android.com>
Message-ID: <AANLkTim8i5vvizBViqFCyq9i+7Uo2E1BrNRf_gtnMb-v@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Feb 19, 2011 at 2:25 PM, Colin Cross <ccross@android.com> wrote:
> Adds CONFIG_TEGRA_DISABLE_BOOTLOADER_CLOCKS that iterates
> through all clocks, disabling any for which the refcount
> is 0 but the clock init detected the bootloader left the
> clock on.


I would argue that any kernel functionality that relies on clocks
being left on my bootloader is buggy, and/or should at least have
those clocks enabled in the static clock tables for the boards in
question, since it creates an undocumented dependency on firmware.

I would prefer if it disabled the clocks by default (after warning),
but that there was a runtime way to override while debugging (i.e. add
a bootarg 'keep_fwclocks' or similar to keep the firmware-enabled
clocks running and just warn about them).


-Olof
