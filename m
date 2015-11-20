From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 20 Nov 2015 12:17:06 +0100
Subject: [PATCH 0/7] Various touchscreens: Support axis inversion / swapping /
 extra gpios
Message-ID: <1448018233-27824-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dimtry and Maxime,

This patch-set extends the of_touchscreen.c helpers to (optionally) also
deal with axis inversion / swapping, and patches a bunch of drivers to use
this new functionality.

One of the modified drivers is the pixcir_i2c_ts driver. Sander Vermin
has been helping me with getting this driver to work on a tablet I own.
This patch-set includes a v2 of Sander's "Input: pixcir_i2c_ts: add wake
and enable gpios" patch. v1 also included axis inversion / swapping support,
which I've redone using the new helpers in a separate patch in this set.

Dmitry can you pickup patches 1-5 please ?
Maxime can you pickup patches 6-7 please ? Merging them seperately
should not be an issue without patches 1-5 the touchscreen will not work
but there will be no other breakage, so no regressions.

Thanks & Regards,

Hans
