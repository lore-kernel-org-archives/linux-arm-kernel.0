From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 06 Feb 2013 16:36:39 -0700
Subject: [PATCH v4 01/10] s5p-csis: Add device tree support
In-Reply-To: <1359745771-23684-2-git-send-email-s.nawrocki@samsung.com>
References: <1359745771-23684-1-git-send-email-s.nawrocki@samsung.com>
 <1359745771-23684-2-git-send-email-s.nawrocki@samsung.com>
Message-ID: <5112E907.4080100@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/01/2013 12:09 PM, Sylwester Nawrocki wrote:
> s5p-csis is platform device driver for MIPI-CSI frontend to the FIMC
> device. This patch support for binding the driver to the MIPI-CSIS
> devices instantiated from device tree and for parsing all SoC and
> board specific properties.

> diff --git a/Documentation/devicetree/bindings/media/soc/samsung-mipi-csis.txt b/Documentation/devicetree/bindings/media/soc/samsung-mipi-csis.txt

> +Optional properties:
> +
> +- clock-frequency : The IP's main (system bus) clock frequency in Hz, default
> +		    value when this property is not specified is 166 MHz;

Shouldn't this be a "clocks" property, so that the driver can call
clk_get(), clk_prepare_enable(), clk_get_rate(), etc. on it?

Other than that this binding seems fine to me at a quick glance.
