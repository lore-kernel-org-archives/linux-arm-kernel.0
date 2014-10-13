From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 13 Oct 2014 15:19:11 +0200
Subject: ARMADA 370 - Distributed Switch Architecture (dsa) - device tree
In-Reply-To: <f1e8d1ba750bfb63f84471d0ec7de988@twien.net>
References: <f1e8d1ba750bfb63f84471d0ec7de988@twien.net>
Message-ID: <20141013131911.GD26864@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 13, 2014 at 12:14:41PM +0200, post at twien.net wrote:
> Dear all,
> I have a custom board equipped with an ARMADA 370 SoC (88f6W11) and
> a Marvell switch chip (88e6352) (I have written a device driver for
> the latter).

Hi Tormon

I think this is the first board anybody has tried DSA with the mvmeta
driver. So there could be issues there. You also need to be a little
bit careful with the kirkwood examples. Until recently, they were
broken.

You dsa node in your DT tree looks good. The dmesg output also seems
O.K. in terms of DSA. It has found the switch, meaning communication
through the ethernet mdio bus is working.

I think the issue is either in your mdio node, or the mvneta driver.

I'm currently working on a D-LINK DIR665, with a DSA setup. This is
kirkwood. My mdio node is simply:

&mdio {
        status = "okay";
};

And the speed and duplex goes into the ethernet node:

&eth0 {
	status = "okay";

	ethernet0-port at 0 {
                speed = <1000>;
                duplex = <1>;
        };
};

The Ethernet node does not have a phandle to a phy node.

Can you try something similar?

    Andrew
