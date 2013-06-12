From: henrik@henriknordstrom.net (Henrik =?ISO-8859-1?Q?Nordstr=F6m?=)
Date: Wed, 12 Jun 2013 10:29:48 +0200
Subject: [linux-sunxi] [PATCHv4 7/9] ARM: sun5i: dt: Add i2c muxing options
In-Reply-To: <1371024438-16631-8-git-send-email-maxime.ripard@free-electrons.com>
References: <1371024438-16631-1-git-send-email-maxime.ripard@free-electrons.com>
 <1371024438-16631-8-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1371025788.4659.20.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ons 2013-06-12 klockan 10:07 +0200 skrev Maxime Ripard:

> +			i2c0_pins_a: i2c0 at 0 {
> +				allwinner,pins = "PB0", "PB1";
> +				allwinner,function = "i2c0";
> +				allwinner,drive = <0>;
> +				allwinner,pull = <0>;

Is this right? All other use pull = 1.

I guess it's board dependent depending on if there is external pullups
or not on the i2c bus. I have seen Allwinner designs both with and
without external pullups.

It will not work well if there is neither internal or external pullup.
And may stress the i2c components a bit if there is both..

Regards
Henrik
