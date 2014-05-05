From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 5 May 2014 22:38:39 +0200
Subject: [E1000-devel] ARM support for igb driver
In-Reply-To: <5367AE02.8030802@intel.com>
References: <CAHH3p5KAwyMOY=ai_h0eM+JwYLtTO8d4jVaVOWVtOakhqPRTew@mail.gmail.com>
 <CF7EA37A.4676A%matthew.vick@intel.com>
 <CAHH3p5JFc3jgeK7OFd1rtgDS3gjRdjiPr3LwwqfyKMPGSTwMWA@mail.gmail.com>
 <CF7FD060.46A87%matthew.vick@intel.com>
 <CAHH3p5J8V6uWEzbCoT+x-6_2x1q=nc=_oMn0qnnj113FmeuW6A@mail.gmail.com>
 <9B4A1B1917080E46B64F07F2989DADD6533627A5@ORSMSX114.amr.corp.intel.com>
 <CAHH3p5KEPXw5mxP-13evd774nyO5C13ky0=fCaZPCNVx1gh3Ow@mail.gmail.com>
 <CAHH3p5LaRwgdECxsO4OZSdWEhGt232yj-3347kYEStP6NLg2xg@mail.gmail.com>
 <5360041A.7030005@intel.com>
 <CAHH3p5L6WM3FaZ19Tw9vUcsk+kERfBKnGC2BRtnftJR1pbSF7g@mail.gmail.com>
 <5367AE02.8030802@intel.com>
Message-ID: <20140505223839.45778902@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Alexander Duyck,

On Mon, 05 May 2014 08:28:02 -0700, Alexander Duyck wrote:

> > 1. So overall issue is any memory/config space access hangs(logs above)
> > if bus master enable bit is set on IGB NIC card,this is not observed
> > with E1000E NIC cards on same platform.
> > 
> > 2. Above issue is repro'able on my ARM platform, not x86 ubuntu. Not
> > sure how much its related to ARM though.
> > 
> > 3. I saw below differences in lspci -vvv output b/w e1000e and igb, I am
> > not sure if this has anything to do with above issue.
> > RC config is same for both cases.
> > 
> > IGB / E1000E
> > 
> > Command Status: INTx+/INTx-
> > PM Status:           NoSoftRst+/NoSoftRst-
> > DevCap:                FLReset-/FLReset+
> > No Dev/Link2 Cap/Sta Registers for E1000E
> > Some differences in AER Registers
> > 
> > 4. Any idea, if this card is verified on ARM by anybody?
> > 
> 
> It seems like you are glossing over the obvious issue.  You said it
> yourself, this works fine on x86.  Therefore this is likely VERY related
> to ARM, or at least your specific ARM platform configuration.

Since I haven't seen the beginning of the thread, I might be completely
off topic. However, I wanted to mention that I have successfully used
and tested an IGB PCIe NIC on an ARM Armada XP platform. If that is
useful, I'd be happy to provide you with additional details upon
request.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
