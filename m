From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 28 Mar 2013 15:37:24 +0530
Subject: [PATCH] arm: omap: RX-51: ARM errata 430973 workaround
In-Reply-To: <20130328095011.GS30923@n2100.arm.linux.org.uk>
References: <517283541.62064.1362124023621.JavaMail.apache@mail81.abv.bg>
 <20130306175120.GP11806@atomide.com> <201303062013.16302@pali>
 <201303241526.59275@pali> <20130327205606.GN10155@atomide.com>
 <20130328095011.GS30923@n2100.arm.linux.org.uk>
Message-ID: <5154165C.4050604@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 March 2013 03:20 PM, Russell King - ARM Linux wrote:
> On Wed, Mar 27, 2013 at 01:56:07PM -0700, Tony Lindgren wrote:
>> * Pali Roh?r <pali.rohar@gmail.com> [130324 07:31]:
>>> it is possible to upstream errata 430973 workaround for RX-51?
>>
>> I think we should make the SMC handling a generic function for ARM.
>>
>> AFAIK just the SMC call numbering is different for various
>> implementations. So the handler and passing of the parameters
>> seems like it should be generic.
> 
> SMC calls vary greatly in how they are handled.  The only thing that's
> generic is issuing the SMC call.  All the setup and what arguments are
> required are completely different from SoC to SoC.
> 
> For example, some SoCs require arguments passed via memory.  Others like
> OMAP its via registers.

Exactly. As somebody said on the list, that code looks identical but
it is not. An SMC with barrier instruction is mostly common and nothing
more than that.

Regards,
Santosh
