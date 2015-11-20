From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 20 Nov 2015 12:33:20 +0100
Subject: [PATCH 0/7] Various touchscreens: Support axis inversion /
 swapping / extra gpios
In-Reply-To: <20151120112245.GC8644@n2100.arm.linux.org.uk>
References: <1448018233-27824-1-git-send-email-hdegoede@redhat.com>
 <20151120112245.GC8644@n2100.arm.linux.org.uk>
Message-ID: <564F0500.6020606@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 20-11-15 12:22, Russell King - ARM Linux wrote:
> On Fri, Nov 20, 2015 at 12:17:06PM +0100, Hans de Goede wrote:
>> This patch-set extends the of_touchscreen.c helpers to (optionally) also
>> deal with axis inversion / swapping, and patches a bunch of drivers to use
>> this new functionality.
>
> What's wrong with using tslib?  tslib supports axis transformations in
> userspace via a set of filters.

Doing this in the kernel when we know that the touchscreen is always
mounted upside down (or rotated 90 degress) on a certain tablet makes things
just work, where as tslib requires manual configuration by the user.

Also most distributions are not even shipping tslib, some of this can be
done with the xf86-input-evdev driver (which is the upstream xorg default
driver for touchscreens) too, but again requires manual configuration and
the same goes for the new libinput stack to which xorg is moving and which
is the default for wayland.

Also note that this patch-set is not adding new functionality. We already
have devicetree-bindings to indicate to the driver that axis inversion /
swapping should be done in the driver, and these are already used in
various drivers. This patch-set just makes it easier to add support for
these already existing (and documented) devicetree properties.

Regards,

Hans
