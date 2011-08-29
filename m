From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 29 Aug 2011 10:40:03 +0200
Subject: [PATCH 1/4 v4] drivers: create a pin control subsystem
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04B24A412A@HQMAIL01.nvidia.com>
References: <1313747630-32258-1-git-send-email-linus.walleij@stericsson.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04B24A3BC0@HQMAIL01.nvidia.com>
	<CACRpkdaZfG4hiGf8vug3EGMRMc0c92xbj=L_HAQcS27DAXYc4Q@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04B24A3EDB@HQMAIL01.nvidia.com>
	<CACRpkdbBBaNFETLLcxeCFZoLbdMok7uRi_o-HcbpYdMtRiGFcw@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04B24A412A@HQMAIL01.nvidia.com>
Message-ID: <CACRpkdahBjE5cyz5i44BNPi-q=+v+HM1hmgCWszuOFNq6xedSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 26, 2011 at 7:33 PM, Stephen Warren <swarren@nvidia.com> wrote:

> However, we'd then need a extra table defining what each locality meant:
>
> function locality list_of_pins_in_function_at_locality
> -------- -------- ------------------------------------
> i2c0 ? ? 0 ? ? ? ?0, 1
> i2c0 ? ? 1 ? ? ? ?2, 3
> (hard-coded into pinmux driver implementation)

I *think* this is what I have implemented in the v5 patch set,
have a look.

> It seems slightly more complex to me to have these two separate tables,
> rather than just iterating over n entries in a single mapping table.

I can deal with it....

> Still, I suppose this an implementation detail. I guess I also need to
> think a little more about how both those models would work with Tegra,
> where special functions are selected at a granularity of pin groups,
> yet GPIO is selected at a granularity of a single pin. Perhaps that
> final table I wrote above (mapping locality to pin list) might also help
> represent Tegra's pin-group- rather than pin-level muxing capabilities...

I have made the assumption that we want to handle groups
of pins, so a certain function in a certain position represents what
the device want to request.

Well, let's look at the code...

Thanks,
Linus Walleij
