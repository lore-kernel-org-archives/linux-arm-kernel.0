From: slash.tmp@free.fr (Mason)
Date: Tue, 3 Nov 2015 21:36:35 +0100
Subject: Cortex-A9 SCU + ARM_ERRATA_764369
In-Reply-To: <5639107E.7030901@free.fr>
References: <5638E61C.30406@free.fr> <20151103172743.GE4049@leverpostej>
 <5639107E.7030901@free.fr>
Message-ID: <56391AD3.8010904@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/2015 20:52, Mason wrote:

> Mark Rutland wrote:
> 
>> Mason wrote:
>>
>>> What is scu_base + 0x30? (SCU diagnostic control register?)
>>
>> It's documented (admittedly very sparsely) in the Software
>> Developers Errata Notice for Cortex-A9 processors, in the
>> section regarding erratum 764369.
> 
> A Freescale document mentions:
> 
>> Set bit[0] in the undocumented SCU diagnostic control register
>> located at offset 0x30 from the PERIPHBASE address. Setting this bit
>> disables the "migratory bit" feature. This forces a dirty cache line
>> to be evicted to the lower memory subsystem?which is both the point
>> of coherency and the point of unification?when it is being read by
>> another processor.
> 
> Can this register be written to by a non-secure OS?

IIUC Rob's message, NS OS cannot write to scu_base + 0x30.
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/244341.html

<confused> Rob stated:
"these types of work-arounds must go into the bootloader or firmware."

Doesn't that apply to 764369 too? (At least the part setting
bit0 in scu_base + 0x30)

If a company is not using a standard boot-loader such as U-Boot,
does that mean it must re-implement all these work-arounds in
its own boot-loader?

Does firmware mean secure OS?

Regards.
