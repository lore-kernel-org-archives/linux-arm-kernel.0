From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 05 Jan 2012 16:13:01 +0000
Subject: [PATCH v2 00/15] Make SMP timers standalone
In-Reply-To: <20120105121026.GS11810@n2100.arm.linux.org.uk>
References: <1324574865-5367-1-git-send-email-marc.zyngier@arm.com>
 <20111222193216.GO2577@n2100.arm.linux.org.uk> <4F048EC4.40900@arm.com>
 <20120104214748.GH11810@n2100.arm.linux.org.uk>
 <CACRpkdZPEYc3xNNb1w4st86bLGMW0ePbEA6+V4opHXe6Sk=u2g@mail.gmail.com>
 <4F0584B5.60908@arm.com>
 <CAMQu2gxuBNRWYKyKRdzvv_m49DyLoODVbC=rKDHDAMTnxe+6+A@mail.gmail.com>
 <4F058744.4030503@arm.com> <20120105112602.GQ11810@n2100.arm.linux.org.uk>
 <4F058B1C.2070109@arm.com> <20120105121026.GS11810@n2100.arm.linux.org.uk>
Message-ID: <4F05CC0D.6090101@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/01/12 12:10, Russell King - ARM Linux wrote:
> On Thu, Jan 05, 2012 at 11:35:56AM +0000, Marc Zyngier wrote:
>> On 05/01/12 11:26, Russell King - ARM Linux wrote:
>>> Look, local timers *are* special.  They're not the same as global timers.
>>> They're treated differently.  Ripping out the local timer setup stuff
>>> from the SMP code is not the right solution, especially when we've
>>> already got a separation of the local timer core from the hardware
>>> implementation.
>>
>> OK. I'll try to work out something different.
> 
> Why?  What's wrong with the existing structure?

My main goal here is not to use a local timer as a global timer, but
rather to be able to support multiple local timer implementations in the
same kernel (TWD, MCT...). The "local timer on UP" is merely a consequence.

I could come up with another registration interface that fits into the
existing structure, but I thought something could be done with what we
currently have.

	M.
-- 
Jazz is not dead. It just smells funny...
