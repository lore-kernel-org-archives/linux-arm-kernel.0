From: alexander.h.duyck@intel.com (Alexander Duyck)
Date: Tue, 06 May 2014 07:58:32 -0700
Subject: [E1000-devel] ARM support for igb driver
In-Reply-To: <CAHH3p5L4DaORYJ8_6zMEY3ikEnABU1L0B2C6Fezb_g6dCjtr5Q@mail.gmail.com>
References: <CAHH3p5KAwyMOY=ai_h0eM+JwYLtTO8d4jVaVOWVtOakhqPRTew@mail.gmail.com>	<CF7EA37A.4676A%matthew.vick@intel.com>	<CAHH3p5JFc3jgeK7OFd1rtgDS3gjRdjiPr3LwwqfyKMPGSTwMWA@mail.gmail.com>	<CF7FD060.46A87%matthew.vick@intel.com>	<CAHH3p5J8V6uWEzbCoT+x-6_2x1q=nc=_oMn0qnnj113FmeuW6A@mail.gmail.com>	<9B4A1B1917080E46B64F07F2989DADD6533627A5@ORSMSX114.amr.corp.intel.com>	<CAHH3p5KEPXw5mxP-13evd774nyO5C13ky0=fCaZPCNVx1gh3Ow@mail.gmail.com>	<CAHH3p5LaRwgdECxsO4OZSdWEhGt232yj-3347kYEStP6NLg2xg@mail.gmail.com>	<5360041A.7030005@intel.com>	<CAHH3p5L6WM3FaZ19Tw9vUcsk+kERfBKnGC2BRtnftJR1pbSF7g@mail.gmail.com>	<5367AE02.8030802@intel.com>	<20140505223839.45778902@skate>	<536800A8.7090801@intel.com>
 <CAHH3p5L4DaORYJ8_6zMEY3ikEnABU1L0B2C6Fezb_g6dCjtr5Q@mail.gmail.com>
Message-ID: <5368F898.2000803@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shiv,

I think we are at the limits of what we can do from the Intel end.
Based on the comments from Thomas it sounds like there shouldn't be any
issues specifically with ARM that prevent the use of IGB PCIe devices,
and the fact is the error your are seeing "Unhandled fault: imprecise
external abort (0x1406) at 0x00000000" can indicate some sort of bus
fault.  It would probably be best to work with someone more familiar
with the inner workings of ARM CPUs as they might be able to work out
some other workarounds for the external abort.

The fact that the Data Link Protocol error was there as well points to
some sort of hardware bus fault.  My advice would be to explore the
reason for why you are getting the Data Link Protocol error as this is
likely the source of the external abort you are seeing.  Beyond that
there isn't much more debugging we can do since this is likely a bus
issue related to your platform configuration.

Thanks,

Alex
