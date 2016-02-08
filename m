From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 8 Feb 2016 10:51:05 +0000
Subject: [PATCH 2/3] arm64: dts: add the Alpine v2 EVP
In-Reply-To: <1454922699-16785-3-git-send-email-antoine.tenart@free-electrons.com>
References: <1454922699-16785-1-git-send-email-antoine.tenart@free-electrons.com>
 <1454922699-16785-3-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20160208105104.GA12991@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> +	chosen {
> +		stdout-path = "console0:115200n8";
> +	};

There is no console0 alias, so this cannot work.

Did you mean serial0?

[...]

> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +		serial2 = &uart2;
> +		serial3 = &uart3;
> +	};

[...]

> +	psci {
> +		compatible = "arm,psci-0.2", "arm,psci";
> +		method = "smc";
> +		cpu_on = <0x84000003>;
> +	};

If you have PSCI 0.2, the cpu_on ID (and all other mandatory function
IDs) are implicit.

If you want to have "arm,psci" as a fallback, then please add the IDs
for functions mandatory in PSCI 0.2 which existed in the "arm,psci"
binding. Otherwise, drop "arm,psci" from the compatible list, along
with the cpu_on function ID.

THanks,
Mark.
