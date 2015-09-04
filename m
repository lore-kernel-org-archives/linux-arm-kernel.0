From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Fri, 04 Sep 2015 22:49:28 +0100
Subject: Porting MIPS IRQ handler to ARM
In-Reply-To: <55E9D8DC.6090201@free.fr> (Mason's message of "Fri, 04 Sep 2015
 19:46:04 +0200")
References: <55E5CED8.7000408@free.fr> <55E5D945.3040504@gmail.com>
 <55E722F2.50905@free.fr> <yw1xy4goyc3z.fsf@unicorn.mansr.com>
 <55E73971.8030406@free.fr> <55E9C33A.2080801@free.fr>
 <yw1x8u8mxht2.fsf@unicorn.mansr.com> <55E9D8DC.6090201@free.fr>
Message-ID: <yw1xzj11x3br.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mason <slash.tmp@free.fr> writes:

> On 04/09/2015 18:36, M?ns Rullg?rd wrote:
>
>> Mason wrote:
>> 
>>> There's just too much DT syntax that flies light-years over my head.
>>> #address-cells, #size-cells, #interrupt-cells, ranges, aliases, etc.
>>> Basically, all I understand is /dts-v1/;
>>> (Anyone have links to good tutorials?)
>>>
>>> I've attached the current version I'm playing with (I tried to make it
>>> as small as possible). If some charitable soul spots an obvious problem...
>>> (Commented blocks have been tested uncommented, of course.)
>> 
>> What happens when you try to boot with this device tree?
>
> It panics in tangox_irq_init IIRC.
>
>> Are you sure these addresses are correct?  Those are the values from
>> tango3.
>
> AFAIU, that HW block hasn't changed in a long time, but I'll
> double-check to be sure.

Even if the HW block itself is unchanged, it may be mapped at a
different address.  ARM and MIPS systems generally have quite
different-looking memory maps, so I'd actually be surprised if hasn't
been moved.

-- 
M?ns Rullg?rd
mans at mansr.com
