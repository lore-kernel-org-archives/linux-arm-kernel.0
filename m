From: khilman@baylibre.com (Kevin Hilman)
Date: Sat, 30 Sep 2017 22:33:59 +0200
Subject: [PATCH 0/8] pinctrl: meson: clean pin offsets
References: <20170920133927.17390-1-jbrunet@baylibre.com>
Message-ID: <7hmv5cdiyw.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> The initial goal of this series was move to TEST_N pin from the EE
> controller to AO controller, where it belongs. This meant modify the
> EE_OFF value.
>
> This offset is a quirk we brought from the vendor driver when it was
> initially merged. There no reason to keep this around and we could simply
> let pinctrl figure the pin base value.
>
> Removing this offset, while simple, ends up being quite a patch bomb.
> This is why I split the change over 5 first patches, so the important
> change, patch #1 remains visible. Of course, to avoid breaking bisect,
> these first 5 patches should be squashed into one. (If you prefer that I
> squash it myself, I may have to send you a PR as the patch would exceed
> VGER 100000 characters limit)
>
> The last change is this series, while not directly related, also requires
> to adjust the gpio-line-names property in DT. Having these changes going
> together would make it easier to coordinate the DTS changes.
>
> This was changeset has been test on gxbb P200, gxl libretech-cc.  It was
> also boot tested on meson8 (Thx Martin!)

Really nice cleanup, thanks!

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

Kevin
