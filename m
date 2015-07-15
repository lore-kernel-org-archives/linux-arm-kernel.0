From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 15 Jul 2015 10:21:01 +0100
Subject: [PATCH v2 4/4] arm64: dts: Add Broadcom North Star 2 support
In-Reply-To: <1436935343-4437-5-git-send-email-rjui@broadcom.com>
References: <1436935343-4437-1-git-send-email-rjui@broadcom.com>
 <1436935343-4437-5-git-send-email-rjui@broadcom.com>
Message-ID: <20150715092101.GB9627@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +		bootargs = "earlycon=uart8250,mmio32,0x66130000";
> +	};

You shouldn't need those earlycon arguments if your driver has
of_earlycon support. If that's currently missing, could you add that
instead?

Thanks,
Mark.
