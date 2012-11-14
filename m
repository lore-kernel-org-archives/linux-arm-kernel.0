From: linux@prisktech.co.nz (Tony Prisk)
Date: Wed, 14 Nov 2012 20:54:01 +1300
Subject: arch-vt8500 and wm8850 support
Message-ID: <1352879641.2728.8.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Just looking for a little advice re: adding support for the WM8850
variant.

At the moment we have the ARM926 variants under ARCH_VT8500. The WM8850
is ARMv7, but uses all the same drivers as the ARM926 versions. At the
moment, all the drivers depend on ARCH_VT8500.

The obvious solution (to me at least) seems to be to have 3 groups -
ARCH_VT8500 keeps everything it has now except 'select CPU_ARM926T', and
we add 2 additional groups - the first for all the current models, which
selects CPU_ARM926T and ARCH_VT8500, and a second for WM8850 which
selects CPU_V7 and ARCH_VT8500.

The other option seems to be to add WM8850 as ARCH_newmodel, but that
would require patching all the driver Kconfigs to depends on ARCH_VT8500
|| ARCH_newmodel.


Interested in your feedback.

Regards
Tony P
