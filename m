From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 16 May 2017 14:34:46 +0200
Subject: [PATCH 1/2] arm64: marvell: dts: fill MachiatoBin board
 description
In-Reply-To: <1494890913-8360-2-git-send-email-mw@semihalf.com>
References: <1494890913-8360-1-git-send-email-mw@semihalf.com>
 <1494890913-8360-2-git-send-email-mw@semihalf.com>
Message-ID: <20170516143446.4a25a306@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 16 May 2017 01:28:32 +0200, Marcin Wojtas wrote:

> +&cps_eth1 {
> +	status = "okay";
> +	phy = <&phy0>;
> +	phy-mode = "sgmii";
> +};

It would be nice to indicate which connector is that, like is done in
the rest of this Device Tree file.

> +&ap_sdhci0 {
> +	status = "okay";
> +	bus-width = <8>;
> +	no-1-8-v;
> +	non-removable;
> +};
> +
> +&cpm_sdhci0 {
> +	status = "okay";
> +	bus-width = <4>;
> +	no-1-8-v;
> +	non-removable;
> +};

Same comment. Also, are they both really non-removable? I have a uSD
card connector on my MacchiatoBin board. It isn't covered by those new
entries ?

Also, fix the wording of MacchiatoBin in your commit title/commit log.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
