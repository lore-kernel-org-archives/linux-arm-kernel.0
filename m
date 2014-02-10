From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon, 10 Feb 2014 16:38:09 +0000
Subject: [RFC PATCH] ARM: Add imprecise abort enable/disable macro
In-Reply-To: <20140210152147.GE2794@e103592.cambridge.arm.com>
References: <1391789955-26927-1-git-send-email-fabrice.gasnier@st.com>
 <1391789955-26927-2-git-send-email-fabrice.gasnier@st.com>
 <20140210141634.GA2794@e103592.cambridge.arm.com>
 <52F8E81E.70804@codethink.co.uk>
 <20140210152147.GE2794@e103592.cambridge.arm.com>
Message-ID: <52F90071.4080604@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/14 15:21, Dave Martin wrote:
> On Mon, Feb 10, 2014 at 02:54:22PM +0000, Ben Dooks wrote:
>> On 10/02/14 14:16, Dave Martin wrote:
>>> On Fri, Feb 07, 2014 at 05:19:15PM +0100, Fabrice GASNIER wrote:
>>>> This patch adds imprecise abort enable/disable macros.
>>>> It also enables imprecise aborts when starting kernel.
>>>
>>> Relying on imprecise aborts for hardware probing would be considered bad
>>> hardware and/or software design for ARM-specific stuff.
>>>
>>> PCI is more generic though, so we may have to put up with this to some
>>> extent.  Can you point me to the affected probing code?  I'm not very
>>> familiar with that stuff...
>>
>> The marvell pcie always had the option of delivering any bus
>> errors as imprecise aborts. However it was /annoying/ and therefore
>
> You don't say ;)
>
>> easier just to turn it off and rely on the hardware returning 0xffff
>> for any configuration area it couldn't get to.
>
> Does PCI have any way of finding out which parts of the configuration
> space are there before you are forced to go poking around in invalid
> address space?
>
> I'm guessing there may not be, otherwise this convsersation might not
> be happening ... but I don't know too much about PCI.

IIRC for configuration accesses you have to wait for the PCIe core
to get a response from the other end. The systems I've seen either
poll for completion or hold the transaction until the pcie core has
finished working.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
