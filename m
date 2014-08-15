From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 15 Aug 2014 17:22:58 +0100
Subject: [PATCH 4/6] arm64: Add DTS support for FSL's LS2085A SoC
In-Reply-To: <7010d864a31e437d9cccebafdb5f50e7@BY2PR0301MB0743.namprd03.prod.outlook.com>
References: <1408096156-29772-1-git-send-email-bhupesh.sharma@freescale.com>
 <1408096156-29772-5-git-send-email-bhupesh.sharma@freescale.com>
 <20140815101249.GA19939@localhost>
 <af793f09683b48b5a0db42a482210c4a@BY2PR0301MB0743.namprd03.prod.outlook.com>
 <20140815131026.GB18863@arm.com>
 <29cf47df79b145ea928da6944ff3de57@BN1PR03MB220.namprd03.prod.outlook.com>
 <20140815152832.GE18863@arm.com>
 <7010d864a31e437d9cccebafdb5f50e7@BY2PR0301MB0743.namprd03.prod.outlook.com>
Message-ID: <20140815162258.GC21908@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stuart

> Is the intent to eventually purge the device trees of enable-method/cpu-release-addr
> and have that set by the boot firmware?  Or, keep the spin-table method 
> around as a least common denominator mechanism and override it when
> necessary?   Wondering what the longer term thinking is...

Personally I'd like to see anything that's not a fixed HW property be
omitted in the DTS and injected by the boot firmware. Certainly anything
which is a property of the FW should be injected by that FW.

That would cover:

- Any enable-method property and related properties and/or nodes. This
  is heavily dependent on the boot firmware configuration, and can
  differ substantially between instances of a given board.

- Most /memreserve/ uses (as these typically protect firmware or
  trampoline code).

- Any memory nodes where memory can be dynamically populated on the
  board.

- CPU nodes if the presence of said CPUs is dynamically determined. 
  
In the long term I'd like to see DTS get fully decoupled from the
kernel.

Cheers,
Mark.
