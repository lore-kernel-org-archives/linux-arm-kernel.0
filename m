From: slash.tmp@free.fr (Mason)
Date: Wed, 23 Sep 2015 10:49:25 +0200
Subject: Steps to submit a new arch/arm port
In-Reply-To: <20150922162947.GC21084@n2100.arm.linux.org.uk>
References: <56001B78.2090001@free.fr> <2206647.QPrIpE2UC0@wuerfel>
 <56016780.5080104@free.fr> <144297172.JfjI0hNJ9J@wuerfel>
 <5601799C.20701@free.fr> <20150922162947.GC21084@n2100.arm.linux.org.uk>
Message-ID: <56026795.3090403@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/09/2015 18:29, Russell King - ARM Linux wrote:
> On Tue, Sep 22, 2015 at 05:54:04PM +0200, Mason wrote:
>> On 22/09/2015 16:51, Arnd Bergmann wrote:
>>> On Tuesday 22 September 2015 16:36:48 Mason wrote:
>>>> On 21/09/2015 17:49, Arnd Bergmann wrote:
>>>> +config ARM_L1_CACHE_SHIFT
>>>> +	int
>>>> +	default 5
>>>
>>> This conflicts with the other definition of the same symbol.
>>
>> I asked about this a long time ago. Maybe I didn't understand
>> Russell's answer?
>>
>> http://thread.gmane.org/gmane.linux.ports.arm.kernel/402968
>>
>> How do I force ARM_L1_CACHE_SHIFT to 5 for my platform?
>> It saves ~6% of the .data section size.
>> (Not worth it?)
> 
> It's really not worth the complexity in Kconfig to make it work - we
> would need some way to detect a configuration where _only_ your
> platform is enabled, and the statement for that is likely to be very
> big, and very difficult to maintain into the future.

Doh! I keep missing the ramifications of the ARCH_MULTIPLATFORM setting.

How about overriding ARM_L1_CACHE_SHIFT *ONLY* when not building an
ARCH_MULTIPLATFORM kernel?

In my platform Kconfig, something along the lines of

config ARM_L1_CACHE_SHIFT
	int
	default 5 if !ARCH_MULTIPLATFORM

Regards.
