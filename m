From: marcus.folkesson@gmail.com (Marcus Folkesson)
Date: Fri, 9 Feb 2018 20:32:25 +0100
Subject: [PATCH 1/7] watchdog: sama5d4: make use of timeout-secs provided
 in devicetree
In-Reply-To: <20180209192724.1227-2-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180209192724.1227-1-marcus.folkesson@gmail.com>
 <20180209192724.1227-2-marcus.folkesson@gmail.com>
Message-ID: <20180209193225.GA1932@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The summary email did not make it for some reason.

However.
All these drivers is using watchdog_init_timeout() to set timeout.
If the timeout-parameter is set to an valid value, it will allways pick
that and not even consider if timeout-secs is set in devicetree.

Most of the patches will just remove the initial value for
timeout-parameter.

Some of the drivers allready has documented device-tree-bindings for
timeout-secs (but will not work), add property for those which not.

I wrote a similiar (tested) patch for imx2 and simply did the same to these drivers.
These patches is *NOT* tested, so please review extra carefully.


Taken from Documentation/watchdog/watchdog-kernel-api.txt:
	The watchdog_init_timeout function allows you to initialize the timeout field
	using the module timeout parameter or by retrieving the timeout-sec property from
	the device tree (if the module timeout parameter is invalid). Best practice is
	to set the default timeout value as timeout value in the watchdog_device and
	then use this function to set the user "preferred" timeout value.


Best regards
Marcus Folkesson
