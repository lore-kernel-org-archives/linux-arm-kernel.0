From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Wed, 02 Dec 2009 18:36:31 +0100
Subject: [PATCH 1/1] fix occasional ULPI timeouts with ehci-mxc
In-Reply-To: <20091202164930.GG14091@buzzloop.caiaq.de>
References: <1259770381-16987-1-git-send-email-valentin.longchamp@epfl.ch>
	<20091202164930.GG14091@buzzloop.caiaq.de>
Message-ID: <4B16A59F.7080004@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Mack a ?crit :
> On Wed, Dec 02, 2009 at 05:13:01PM +0100, Valentin Longchamp wrote:
>> On various mxc boards, the intial ULPI reads resulted in a timeout
>> which prevented the transceiver to be identified and thus the ehci
>> device to be probed.
>>
>> Initializing the hardware lines connected to the transceiver (through
>> pdata->init call) before actually enabling clocks and configuring
>> registers in the devices fixes this problem.
> 
> Hmm, glad to hear it fixed your problem :) However, there is no real
> ULPI communication done on the viewports before the board specific
> init function is called, and the timeouts that are reported come from
> the transceiver probing which is called at a later point.
> 
> Even with that patch applied, one board I have here fails to initialize
> the OTG port.
> 
can you probe the DIR signal (pin 19) of the ISP1504 when you have the 
problem ?

Eric
