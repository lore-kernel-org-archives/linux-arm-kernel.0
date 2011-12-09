From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 10 Dec 2011 00:55:58 +0100
Subject: [RFC 1/3] pinctrl: add a driver for NVIDIA Tegra
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF17518604D7@HQMAIL01.nvidia.com>
References: <1323382390-14892-1-git-send-email-swarren@nvidia.com>
 <1323382390-14892-2-git-send-email-swarren@nvidia.com>
 <CACRpkdYDn0V7SeQuFiFDMxGkybvg6PGf7jxid8ECGB7Azkj3zw@mail.gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17518604D7@HQMAIL01.nvidia.com>
Message-ID: <CACRpkdahqb0qMVcKF9NBT5pwRgK4FOob5ABtb7ids9Bhh5XbZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 9, 2011 at 6:28 PM, Stephen Warren <swarren@nvidia.com> wrote:

> Hence, there's no point parsing it from device tree; we end up with exactly
> the same data in the driver, yet have spent a bunch of time parsing it out
> from device tree instead of just embedding it into the kernel binary.

For me there are two points:

- Avoiding clash with kernel maintainers who hate firmware-like tables and
  binary data filling up the kernel. Some certain other guy bearing my
  name comes to mind.

- Footprint: the majority of the stuff in your driver ends up in non-discardable
  memory, and will be kept around. Since we have this concept of a
  single zImage for a number of say ARMv7 systems, and since pin
  controllers can be pretty hard to load from modules, *all* of them
  may have to be compiled-in. If every driver for every board takes this
  approach I am afraid it will be end up with a measurable footprint.

Yours,
Linus Walleij
