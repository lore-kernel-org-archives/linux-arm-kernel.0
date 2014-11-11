From: davem@davemloft.net (David Miller)
Date: Tue, 11 Nov 2014 13:39:21 -0500 (EST)
Subject: [PATCH v2] VNIC: Adding support for Cavium ThunderX network
 controller
In-Reply-To: <1415596445-10061-1-git-send-email-rric@kernel.org>
References: <1415596445-10061-1-git-send-email-rric@kernel.org>
Message-ID: <20141111.133921.243613958949858000.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Richter <rric@kernel.org>
Date: Sun,  9 Nov 2014 21:14:05 -0800

> +config NET_VENDOR_CAVIUM
 ...
> +config THUNDER_NIC_PF
...
> +config THUNDER_NIC_VF
 ...
> +config	THUNDER_NIC_BGX

These config options seem excessive, if not confusing.  What would a
distribution be expected to enable?  Everything?

> +# Don't change the order, NICPF driver is dependent on BGX driver init
> +obj-$(CONFIG_THUNDER_NIC_BGX) += thunder_bgx.o
> +obj-$(CONFIG_THUNDER_NIC_PF) += nicpf.o
> +obj-$(CONFIG_THUNDER_NIC_VF) += nicvf.o

Nothing ensures ordering if these things are built all modular.

Such ordering dependencies need to be resolved in another way.
