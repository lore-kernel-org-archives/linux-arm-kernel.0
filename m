From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 24 Apr 2018 14:39:44 -0500
Subject: [PATCH 00/11] platform: device tree support for early platform
 drivers
In-Reply-To: <20180424173051.15099-1-brgl@bgdev.pl>
References: <20180424173051.15099-1-brgl@bgdev.pl>
Message-ID: <CAL_JsqLcoPK-dDWjwrS82RRG-WLKePfDgHJcBKRQWZG5PszrKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 12:30 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Device tree based systems often use OF_DECLARE() macros for devices
> that need to be initialized early in the boot process such as clocks,
> timers etc. However platform devices are more desirable.

Yes, platform devices would be more desirable, but ...
>
> This series aims at introducing support for early platform drivers for
> OF-based systems.

... the whole early_platform_device infrastructure is not really a
platform_device. Rather it kind of looks like one and I guess gets
converted over during boot.

This is not the first attempt to add DT support to early platform
devices[1]. I think the same objections still apply. It has been
pretty much only an SH thing (which as an arch, I'm told is pretty
much unmaintained and broken).

> The idea is to have a special compatible fallback string: "earlydev"
> that similarily to "syscon" would be added to device nodes that need
> early probing. We then need to call of_early_platform_populate() early
> in the boot process to actually probe the registered devices.

Others have sufficiently explained why this won't fly for DT, so I
don't have more to add.

Rob

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/054529.html
