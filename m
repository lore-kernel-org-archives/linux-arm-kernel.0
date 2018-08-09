From: marek.behun@nic.cz (=?UTF-8?q?Marek=20Beh=C3=BAn?=)
Date: Thu,  9 Aug 2018 04:20:30 +0200
Subject: [PATCH v2 0/7] Add support for the Turris Mox router
Message-ID: <20180809022037.12001-1-marek.behun@nic.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds preliminary support for the Turris Mox SOHO router developed by CZ.NIC
to mainline kernel.

The differences from previous version of these patches:

The 1st patch should also change some devicetree bindings Documentation.
Previously I only used the code change from the original patches from
linux-marvell.
I also corrected the name of the commit as Andrew pointed out I should.

In the 2nd patch, which adds support for the Moxtet bus, I added code
to check if a driver for the subdevice has it's it_table NULL. If so,
the driver can be specifier only via device tree.

The 3rd patch, which adds support for GPIOs over Moxtet bus, I made the
code more generic, so that it does not only support the current SFP cage
module, but, in the future, maybe others.

In the 7th patch only a typo in commit name was changed.

Marek
