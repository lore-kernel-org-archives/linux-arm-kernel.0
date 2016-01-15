From: john.stultz@linaro.org (John Stultz)
Date: Fri, 15 Jan 2016 12:27:57 -0800
Subject: [PATCH v2 2/4] power: reset: add reboot mode driver
In-Reply-To: <1452598319-8324-1-git-send-email-andy.yan@rock-chips.com>
References: <1452598029-8222-1-git-send-email-andy.yan@rock-chips.com>
 <1452598319-8324-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <CALAqxLVNUG_cVbavXC34sNPv68jbMghti31+PrgQ7mpPngXh6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2016 at 3:31 AM, Andy Yan <andy.yan@rock-chips.com> wrote:
> This driver parse the reboot commands like "reboot loader"
> and "reboot recovery" to get a boot mode described in the
> device tree , then call the write interfae to store the boot
> mode in some persistent storage  like special register or ram,
> which can be read by the bootloader after system reboot, then
> the bootloader can take different action according to the mode
> stored.
>
> This is commonly used on Android based devices, which in order
> to reboot the device into fastboot or recovery mode.
>
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>


Hey Andy!
  Thanks for keeping this work going! I've just successfully reworked
my Nexus7 tree to use your implementation (using the syscon version,
setting up a syscon for IMEM as Bjorn had requested earlier).

All is working well so far!

The one thing I was working on supporting with my own version that
seems to be missing here are for devices that use string based codes,
rather then magic numbers.

This was mostly a theoretical issue. I think the Galaxy Nexus used it,
and when I was looking at some of the HTC devices, they support a text
based reason along with the magic code, but at least in some
implementations the text mode isn't used, so I suspect there its just
for extra debugging.  So this may not be critical to solve until
someone tries to add support for such a device.

Anyway, I'm going to look at porting this to the HiKey board next
(which just uses reserved ram, not syscon), so I'll try to do a an
SRAM driver implementaiton to see how that goes.

thanks!
-john
