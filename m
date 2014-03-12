From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Mar 2014 12:20:01 +0100
Subject: [PATCH 2/2] ARM: dts: berlin2q: add the Marvell BG2-Q DMP device
 tree
In-Reply-To: <1394622364-6848-3-git-send-email-antoine.tenart@free-electrons.com>
References: <1394622364-6848-1-git-send-email-antoine.tenart@free-electrons.com>
 <1394622364-6848-3-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <4569718.jGyZ5WigRr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 March 2014 12:06:04 Antoine T?nart wrote:
> +
> +       soc {
> +               apb at fc0000 {
> +                       uart0: uart at 9000 {
> +                               status = "okay";
> +                       };
> +               };
> +       };
> +};


No need to duplicate both the label and the hierarchy here. The easiest
way to do this is just

	&uart0 {
		status = "okay";
	};

since you already have the label.

	Arnd
