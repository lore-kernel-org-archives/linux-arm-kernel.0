From: psidhu@gateworks.com (Pushpal Sidhu)
Date: Tue, 6 Oct 2015 14:52:25 -0700
Subject: i.mx6 video out in mainline
Message-ID: <CAD1M060ucNEjPceeK9R2s4drkZE1EWEadB1JtcUmnfuNx24zkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

I'm attempting to use a standard fb console (using the
imx6qdl-gw54xx.dtsi), but I find that it only draws to the 1024x768p
portion of the screen. This is also true when running the userspace
tool fb-test.

When I $(cat /sys/class/graphics/fb0/modes), I see only the 1024x768p
resolution there. I verified that the edid read from the monitor is
correct, and that all of it's modes were properly read (in the
drm_mode_std function and enumerated in
/sys/devices/soc0/display-subsystem/drm/card0/card0-HDMI-A-1/modes),
but I can't figure out how to choose a different resolution. I've also
verified that dpms is 'On'.

The monitor appears to think that a 1080p signal is coming in, which
might have to do with the virtual size being set to 1080p. I should
note that I'm not running X11. Is there something I am missing that's
required for changing framebuffer resolutions? Thanks ahead of time.

- Pushpal
