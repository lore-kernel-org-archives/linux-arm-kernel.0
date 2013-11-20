From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 20 Nov 2013 19:21:02 +0100
Subject: [PATCH 2/2] memory: ti-aemif: add bindings for AEMIF driver
In-Reply-To: <1384962416-14862-3-git-send-email-ivan.khoronzhuk@ti.com>
References: <1384962416-14862-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1384962416-14862-3-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <20131120182102.GK14627@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +				the chip select signal.
> +				Minimum value is 1 (0 treated as 1).
> +
> +- ti,cs-wsetup:		write setup width, ns
> +				Time between the beginning of a memory cycle
> +				and the activation of write strobe.
> +				Minimum value is 1 (0 treated as 1).
> +
> +- ti,cs-wstrobe:	write strobe width, ns
> +				Time between the activation and deactivation of
> +				the write strobe.
> +				Minimum value is 1 (0 treated as 1).
> +
> +- ti,cs-whold:		write hold width, ns
> +				Time between the deactivation of the write
> +				strobe and the end of the cycle (which may be
> +				either an address change or the deactivation of
> +				the chip select signal.
> +				Minimum value is 1 (0 treated as 1).
> +
> +If any of the above parameters are absent, current parameter value will be taken
> +from the corresponding HW reg.
> +
> +The name for cs node must be in format csN, where N is the cs number.

this is wired we should use reg instead to represent the cs as done for SPI
or a an other property

Best Regards,
J.
