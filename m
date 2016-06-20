From: stuart.yoder@nxp.com (Stuart Yoder)
Date: Mon, 20 Jun 2016 15:28:18 +0000
Subject: SMMU driver and stall vs terminate mode
Message-ID: <HE1PR04MB1641B0F8442061E3437037628D2A0@HE1PR04MB1641.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robin/Will,

Right now the SMMU driver is hardcoded to configure 'stall' mode for
context faults:

      /* SCTLR */
      reg = SCTLR_CFCFG | SCTLR_CFIE | SCTLR_CFRE | SCTLR_M | SCTLR_EAE_SBOP;

We are running into an issue with a device where it seems behave sanely
when SCTLR_CFCFG=0 ...i.e. 'terminate' mode, but in stall mode seems to be
unaware that an access violation occurred.

Is there really some assumption that all devices that send transcactions
through the SMMU _must_ be able to handle stall mode?  I am trying to
find out from our hw designers what is going on at the signal level for
the device in question, but it seems to me that 'terminate' mode exists
for a reason and I wonder what your thoughts are about providing a
configuration option to allow configuration of terminate mode if a particular
SoC requires it.

Thanks,
Stuart
