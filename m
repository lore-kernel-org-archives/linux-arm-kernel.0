From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 15 Aug 2016 17:57:59 -0500
Subject: [PATCH] pinctrl: meson: get rid of unneeded domain structures
In-Reply-To: <1471110078-5946-1-git-send-email-b.galvani@gmail.com> (Beniamino
 Galvani's message of "Sat, 13 Aug 2016 19:41:18 +0200")
References: <1471110078-5946-1-git-send-email-b.galvani@gmail.com>
Message-ID: <m2a8gdabd4.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Beniamino Galvani <b.galvani@gmail.com> writes:

> The driver originally supported more domains (register ranges) per
> pinctrl device, but since commit 9dab1868ec0d ("pinctrl: amlogic: Make
> driver independent from two-domain configuration") each device gets
> assigned a single domain and we instantiate multiple pinctrl devices
> in the DT.
>
> Therefore, now the 'meson_domain' and 'meson_domain_data' structures
> don't have any reason to exist and can be removed to make the model
> simpler to understand. This commit doesn't change behavior.
>
> Tested on a Odroid-C2.
>
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>

Looks good and boot tested on meson-gxbb-p200:

Acked-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>

Kevin
