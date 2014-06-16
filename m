From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 16 Jun 2014 20:24:27 +0200
Subject: [PATCH 0/2] touchscreen: sun4i-ts: fix reported temperature on A10
Message-ID: <1402943069-19420-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dmitry and Maxime,

I've learned today that the temperature reported on the A10 / sun4i SoC family
is aprox twice too high, since the A10 rtp controller temperature register
seems to have double the resolution (one bit more) then that of the A13
(sun5i) and later.

Dmitry, can you please add the sun4i-ts.c patch to your tree? Ideally
as a bug-fix for 3.16 (where this driver was first added).

Maxime, can you please add the dts patch to your tree ?

Thanks & Regards,

Hans
