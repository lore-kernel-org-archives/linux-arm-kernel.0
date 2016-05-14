From: khilman@baylibre.com (Kevin Hilman)
Date: Sat, 14 May 2016 10:45:54 -0700
Subject: [RFC PATCH 1/3] reset: Add support for the Amlogic Meson GXBB
 Reset Controller
In-Reply-To: <1463148012-25988-2-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Fri, 13 May 2016 16:00:10 +0200")
References: <1463148012-25988-1-git-send-email-narmstrong@baylibre.com>
 <1463148012-25988-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <7hzirsh6st.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> This patch adds the platform driver for the Amlogic Meson GXBB Reset
> Controller.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

[...]

> +struct meson_gxbb_reset {
> +	void *reg_base;

nit: along wit the readw/writel, this should be void __iomem *.

> +	struct reset_controller_dev rcdev;
> +};

Kevin
