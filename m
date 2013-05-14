From: david.lanzendoerfer@o2s.ch (David =?iso-8859-1?Q?Lanzend=F6rfer?=)
Date: Tue, 14 May 2013 20:17:46 +0200
Subject: Naming convention DSI + device tree
Message-ID: <20130514181745.GA2762@mail.o2s.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello
I have the following issue:
In order to make the DSI controller react at all, I need to pass him a certain combination of pin states.
Until now within the code of the original android kernel which was using board files this has just been
done by doing bit banging.

namely:
	gpio_set_value(tf201_lvds_shutdown, 1);
	mdelay(20);
	gpio_set_value(TEGRA_GPIO_PH0, 1);
	mdelay(10);
	gpio_set_value(TEGRA_GPIO_PH2, 1);
	mdelay(15);
	gpio_set_value(TEGRA_GPIO_PU2, 0);
	gpio_set_value(TEGRA_GPIO_PU2, 1);
	mdelay(10);
	gpio_set_value(TEGRA_GPIO_PU2, 0);
	mdelay(10);
	gpio_set_value(TEGRA_GPIO_PU2, 1);
	mdelay(15);

Now with a device tree comes the question: Where should I put this?
Also because I don't have the schematics of the TF201 (for obvious reasons)
I won't be able to name the pin assignments of the DSI controller
in a generic driver correctly.
Would be neat if an ASUS engineer with the schematic at hand could
figure out what pins these are and could name the pin assignment.

best regards
David
