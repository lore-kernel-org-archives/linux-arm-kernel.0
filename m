From: saeed@marvell.com (Saeed Bishara)
Date: Sun, 24 Oct 2010 13:13:53 +0200
Subject: QNAP TS-209 broken by "orion/kirkwood: reset PCIe unit on boot"
In-Reply-To: <alpine.LFD.2.00.1010211608550.2764@xanadu.home>
References: <20101019190533.GA11893@jirafa.cyrius.com>
	<alpine.LFD.2.00.1010191529100.2764@xanadu.home>
	<FCBE654890C0334289D0AD3AF4EF009FD18F0B415F@IL-MB01.marvell.com>
	<alpine.LFD.2.00.1010211608550.2764@xanadu.home>
Message-ID: <FCBE654890C0334289D0AD3AF4EF009FE1475A992C@IL-MB01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 

>-----Original Message-----
>From: Nicolas Pitre [mailto:nico at fluxnic.net] 
>Sent: Thursday, October 21, 2010 10:25 PM
>To: Saeed Bishara
>Cc: Martin Michlmayr; Olaf Rempel; buytenh at wantstofly.org; 
>brl at pcpool00.mathematik.uni-freiburg.de; 
>linux-arm-kernel at lists.infradead.org
>Subject: RE: QNAP TS-209 broken by "orion/kirkwood: reset PCIe 
>unit on boot"
>
>On Thu, 21 Oct 2010, Saeed Bishara wrote:
>
>> >
>> >> I noticed that 2.6.36-rc no longer boots on my QNAP TS-209.  I get
>> >> some output but then the machine resets.
>> >> 
>> >> I've bisected it down to the patch "orion/kirkwood: reset 
>PCIe unit on
>> >> boot".  I remember this patch was controversial when it 
>was proposed.
>> >> Looks like it breaks at least one orion5x machine.  Maybe 
>the patch
>> >> should be reverted for now or only be called on kirkwood.
>> >
>> >According to the log, you did agree with that patch at the time.
>> >
>> >Keeping it causes breakage.  Removing it causes breakage 
>too.  So I'd 
>> >much prefer if a solution to solve both breakages was 
>merged instead.
>> We couln't pinpoint the root cause of this issue, actually 
>we failed to reproduce that issue.
>> Nico, I suggest to apply the orion_pcie_reset() only for the 
>boards we the issue had been observed.
>> saeed
>
>OK, so I did, and pushed the result to the Orion git tree 
>(git://git.kernel.org/pub/scm/linux/kernel/git/nico/orion.git).
>
>Can I have confirmation that 1) new breakages are gone, and 2) the 
>device where this reset did fix problems are still OK with this change?
The orignal issue reported on Synology DS409 (also kirkwood based), but that board is not supported in mainline yet.
saeed
>
>
>Nicolas
>
