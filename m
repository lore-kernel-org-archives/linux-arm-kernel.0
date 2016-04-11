From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 11 Apr 2016 10:02:07 +0100
Subject: [RESEND PATCH v2 3/4] arm64: dts: Add dts files for LG
 Electronics's lg1312 SoC
In-Reply-To: <1460338020-28999-4-git-send-email-chanho.min@lge.com>
References: <1460338020-28999-1-git-send-email-chanho.min@lge.com>
 <1460338020-28999-4-git-send-email-chanho.min@lge.com>
Message-ID: <20160411090207.GB7088@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2016 at 10:26:59AM +0900, Chanho Min wrote:
> +	psci {
> +		compatible  = "arm,psci" ,"arm,psci-0.2";
> +		method = "smc";
> +		cpu_suspend = <0x84000001>;
> +		cpu_off = <0x84000002>;
> +		cpu_on = <0x84000003>;
> +	};

The compatible list should be the other way around:

		compatible = "arm,psci-0.2", "arm,psci";

Otherwise this looks ok to me.

Thanks,
Mark.
