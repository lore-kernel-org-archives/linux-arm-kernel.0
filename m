From: alexander.h.duyck@intel.com (Alexander Duyck)
Date: Mon, 05 May 2014 08:28:02 -0700
Subject: [E1000-devel] ARM support for igb driver
In-Reply-To: <CAHH3p5L6WM3FaZ19Tw9vUcsk+kERfBKnGC2BRtnftJR1pbSF7g@mail.gmail.com>
References: <CAHH3p5KAwyMOY=ai_h0eM+JwYLtTO8d4jVaVOWVtOakhqPRTew@mail.gmail.com>	<CF7EA37A.4676A%matthew.vick@intel.com>	<CAHH3p5JFc3jgeK7OFd1rtgDS3gjRdjiPr3LwwqfyKMPGSTwMWA@mail.gmail.com>	<CF7FD060.46A87%matthew.vick@intel.com>	<CAHH3p5J8V6uWEzbCoT+x-6_2x1q=nc=_oMn0qnnj113FmeuW6A@mail.gmail.com>	<9B4A1B1917080E46B64F07F2989DADD6533627A5@ORSMSX114.amr.corp.intel.com>	<CAHH3p5KEPXw5mxP-13evd774nyO5C13ky0=fCaZPCNVx1gh3Ow@mail.gmail.com>	<CAHH3p5LaRwgdECxsO4OZSdWEhGt232yj-3347kYEStP6NLg2xg@mail.gmail.com>	<5360041A.7030005@intel.com>
 <CAHH3p5L6WM3FaZ19Tw9vUcsk+kERfBKnGC2BRtnftJR1pbSF7g@mail.gmail.com>
Message-ID: <5367AE02.8030802@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/04/2014 11:55 PM, shiv prakash Agarwal wrote:
> + linux-arm-kernel mailing list.
> 
> Thanks Alex,
> 
> 1. So overall issue is any memory/config space access hangs(logs above)
> if bus master enable bit is set on IGB NIC card,this is not observed
> with E1000E NIC cards on same platform.
> 
> 2. Above issue is repro'able on my ARM platform, not x86 ubuntu. Not
> sure how much its related to ARM though.
> 
> 3. I saw below differences in lspci -vvv output b/w e1000e and igb, I am
> not sure if this has anything to do with above issue.
> RC config is same for both cases.
> 
> IGB / E1000E
> 
> Command Status: INTx+/INTx-
> PM Status:           NoSoftRst+/NoSoftRst-
> DevCap:                FLReset-/FLReset+
> No Dev/Link2 Cap/Sta Registers for E1000E
> Some differences in AER Registers
> 
> 4. Any idea, if this card is verified on ARM by anybody?
> 

It seems like you are glossing over the obvious issue.  You said it
yourself, this works fine on x86.  Therefore this is likely VERY related
to ARM, or at least your specific ARM platform configuration.

You also mention "some differences in the AER Registers", how about you
tell us what was different there since as I pointed out that could tell
us if there is some error the device detected that is triggering the
problem, or better yet could you just send us the lspci -vvv output from
the problem system.  That would give us much more to work with and help
us to understand what the issue is.

Thanks,

Alex
