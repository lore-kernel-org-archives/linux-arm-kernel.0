From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 6 Jun 2017 11:36:26 +0200
Subject: [PATCH] arm64: dts: marvell: 8040-mcbin: Enable 1GB Ethernet
In-Reply-To: <87h8ztjwz0.fsf@arm.com>
References: <20170605200107.7692-1-marc.zyngier@arm.com>
 <20170606110234.239d2c4a@free-electrons.com>
 <20170606110603.2dafb7ed@free-electrons.com>
 <87h8ztjwz0.fsf@arm.com>
Message-ID: <20170606113626.197efbf7@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 06 Jun 2017 10:18:11 +0100, Marc Zyngier wrote:

> > So perhaps we should indeed keep Marc's patch, enabling just the 1GB
> > Ethernet interface.  
> 
> Whichever patch we merge, Andrew's comment remains. Should we stick with
> "phy", or switch to "phy-handle" everywhere?

Since the binding says to use phy-handle, we should use phy-handle for
your patch. Of course, progressively, we should migrate all our
bindings to this new property name, but I don't think this should be a
prerequisite for your patch to go in.

Side note: I don't understand this change from "phy" to "phy-handle".
It really doesn't make sense to me to encode the type of the property
in the name of the property. Are we going to use:

  phy-mode-string = "sgmii";
  pinctrl-0-handle = <&foo>;
  reg-u32s = <0xdeadbeef 0xbadcafe>;

is there a pointer to the reasoning for this change?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
