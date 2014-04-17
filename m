From: abrestic@chromium.org (Andrew Bresticker)
Date: Thu, 17 Apr 2014 11:23:50 -0700
Subject: [PATCH 0/7] Add cros_ec changes for newer boards
In-Reply-To: <1397757570-19750-1-git-send-email-dianders@chromium.org>
References: <1397757570-19750-1-git-send-email-dianders@chromium.org>
Message-ID: <CAL1qeaE+8km8K4gJvFaYiBxvVO+SD16f17w8pqdHS=OQB4SEoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Doug,

> This series adds the most critical cros_ec changes for newer boards
> using cros_ec.  Specifically:
> * Fixes timing/locking issues with the previously upstreamed (but
>   never used upstream) cros_ec_spi driver.
> * Updates the cros_ec header file to the latest version which allows
>   us to use newer EC features like i2c tunneling.
> * Adds an i2c tunnel driver to allow communication to the EC's i2c
>   devices.
>
> This _doesn't_ get the EC driver fully up to speed with what's in the
> current Chromium OS trees.  There are a whole slew of cleanup patches
> there, an addition of an LPC transport mode, and exports of functions
> to userspace.  Once these patches land and we have functionality we
> can continue to pick more cleanup patches.

I can now talk to the charger and battery over the tunnel on my
Venice2 and other communication with the EC still works, so:

Tested-by: Andrew Bresticker <abrestic@chromium.org>
