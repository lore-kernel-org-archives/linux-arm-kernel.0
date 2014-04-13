From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 13 Apr 2014 17:41:18 +0200
Subject: [PATCH 20/29] ARM: orion5x: convert edmini_v2 to DT pinctrl
In-Reply-To: <20140413152605.GB10033@lunn.ch>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397400006-4315-21-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140413152605.GB10033@lunn.ch>
Message-ID: <20140413174118.6b7304d4@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Sun, 13 Apr 2014 17:26:05 +0200, Andrew Lunn wrote:

> One of the things Sebastian did as part of his Kirkwood DT cleanup was
> sort pinctrl nodes by label, instead of mpp number. We should probably
> discuss this and come to a conclusion before converting Orion5x
> platforms.

Sorting by label may be a good idea, because sorting by MPP does not
necessarily make a lot of sense when some pinctrl configurations
include several pins. Like how would you sort:

config-foo {
	marvell,pins = "mpp2";
	...
};

config-bar {
	marvell,pins = "mpp1", "mpp13";
	...
};

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
