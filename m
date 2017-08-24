From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 24 Aug 2017 09:22:33 +0100
Subject: [PATCH v2 0/8] ELF-FDPIC support for ARM
In-Reply-To: <alpine.LFD.2.20.1708231158090.14288@knanqh.ubzr>
References: <20170817072347.19990-1-nicolas.pitre@linaro.org>
 <20170817083716.GN20805@n2100.armlinux.org.uk>
 <alpine.LFD.2.20.1708231158090.14288@knanqh.ubzr>
Message-ID: <38b1d822-345d-0b79-6d44-b78649e46efb@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/08/17 17:41, Nicolas Pitre wrote:
> On Thu, 17 Aug 2017, Russell King - ARM Linux wrote:
> 
>> On Thu, Aug 17, 2017 at 03:23:39AM -0400, Nicolas Pitre wrote:
>>> This series provides the needed changes to suport the ELF_FDPIC binary
>>> format on ARM. Both MMU and non-MMU systems are supported. This format
>>> has many advantages over the BFLT format used on MMU-less systems, such
>>> as being real ELF that can be parsed by standard tools, can support
>>> shared dynamic libs, etc.
>>
>> I don't see anything issues from the core arch point of view with this,
>> most of it looks straight forward, and the impact on existing users
>> should be low.  However, it would be nice to get some acks (if possible)
>> for the non-arch stuff and some tested-by's on this.
> 
> Well...
> 
> I did prod a few people for testing. Either they're on vacation, or not 
> interested, but I've received no tested-by's nor ACK's what so ever at 
> this point. I did test it myself of course, on both MMU and non-MMU 
> targets, and with static and dynamic binaries.

IIRC, Andras (CCed) has been running FDPIC for a while. Also, I can try to
give it a go on M/R class systems around next week.

I've noticed under Mickael's repo extra patches:

- Add tls support for cortex-m cpu family
- Workaround to fix futex bug on mmu less

It'd be nice if you shed some light on why they are not present in your
series.

Thanks
Vladimir
