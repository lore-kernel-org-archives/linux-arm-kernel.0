From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 5 Mar 2016 15:10:11 +0100
Subject: [PATCH 1/3] usb: core: add power sequence for USB devices
In-Reply-To: <20160305083347.GA28858@shlinux2.ap.freescale.net>
References: <1456999276-6315-1-git-send-email-peter.chen@nxp.com>
 <1456999276-6315-2-git-send-email-peter.chen@nxp.com>
 <CAL_JsqLYHzb0ABYN_P9ZOEorT6otvn_BPNzuCFhoqwa5M4y-hw@mail.gmail.com>
 <20160304020242.GB30272@shlinux2.ap.freescale.net>
 <20160304022305.GB20597@lunn.ch>
 <20160304023750.GF30272@shlinux2.ap.freescale.net>
 <20160305042854.GW13525@rob-hp-laptop>
 <20160305083347.GA28858@shlinux2.ap.freescale.net>
Message-ID: <20160305141011.GA28343@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> So, would you like to accept the generic solution like below:
> 
> - Create a generic power sequence driver, and it will be probed
> according to compatible string at device tree. At its probe,
> we can create a power sequence structure, and let this structure
> as the private data for this power sequence device.

I'm not sure a separate driver is required. Why not consider it more
like pinctrl properties? They are listed in the devices node. Have the
bus enumerate code first walk all children and run their on sequence.
Bus shutdown would again walk the children and run the off sequence.

    Andrew 
