From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 8 Mar 2014 11:59:48 +0000
Subject: [PATCH v2] dt: platform driver: Fill the resources before
 probe and defer if needed
In-Reply-To: <20140308073758.DA63FC408EC@trevor.secretlab.ca>
References: <20140220153042.DF053C4050F@trevor.secretlab.ca>
 <1392988720-20976-1-git-send-email-jjhiblot@traphandler.com>
 <20140308073758.DA63FC408EC@trevor.secretlab.ca>
Message-ID: <20140308115948.GX21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 08, 2014 at 07:37:58AM +0000, Grant Likely wrote:
> I believe we already talked about the above test. This function must
> only process devices created by of_platform_populate(). Merely checking
> the of_node pointer is not a sufficient test because there are other
> paths in the kernel for creating platform_devices that might get a node
> pointer attached to it.

There definitely are: there are a number of platform device drivers
which create a new platform device structure, and copy the of_node
pointer across.

However, that's really sick code, and can result in the platform device
driver probing the device it just created... this practise should be
outlawed.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
