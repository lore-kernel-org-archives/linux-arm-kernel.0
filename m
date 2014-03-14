From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Mar 2014 12:42:17 +0100
Subject: [PATCH v17 4/4] arm64: Add APM X-Gene SoC AHCI SATA host
 controller DTS entries
In-Reply-To: <1394655573-32645-5-git-send-email-lho@apm.com>
References: <1394655573-32645-1-git-send-email-lho@apm.com>
 <1394655573-32645-4-git-send-email-lho@apm.com>
 <1394655573-32645-5-git-send-email-lho@apm.com>
Message-ID: <201403141242.17669.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 March 2014, Loc Ho wrote:
> +                       sata01clk: sata01clk at 1f21c000 {
> +                               compatible = "apm,xgene-device-clock";
> +                               #clock-cells = <1>;
> +                               clocks = <&socplldiv2 0>;
> +                               clock-names = "socplldiv2";
> +                               reg = <0x0 0x1f21c000 0x0 0x1000>;
> +                               reg-names = "csr-reg";
> +                               clock-output-names = "sata01clk";
> +                               csr-offset = <0x4>;
> +                               csr-mask = <0x05>;
> +                               enable-offset = <0x0>;
> +                               enable-mask = <0x39>;

Same comment about the "clock-names" as in the first patch here.

	Arnd
