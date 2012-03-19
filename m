From: robherring2@gmail.com (Rob Herring)
Date: Mon, 19 Mar 2012 11:36:53 -0500
Subject: [PATCH] ARM: lib: use LDRD/STRD for data copy
In-Reply-To: <20120319154123.GP15988@n2100.arm.linux.org.uk>
References: <007201cd059e$4af2cc10$e0d86430$%kim@samsung.com>
 <20120319085503.GL15988@n2100.arm.linux.org.uk> <4F674479.8090101@gmail.com>
 <20120319154123.GP15988@n2100.arm.linux.org.uk>
Message-ID: <4F6760A5.9040506@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19/2012 10:41 AM, Russell King - ARM Linux wrote:
> On Mon, Mar 19, 2012 at 09:36:41AM -0500, Rob Herring wrote:
>> On 03/19/2012 03:55 AM, Russell King - ARM Linux wrote:
>>> On Mon, Mar 19, 2012 at 04:02:48PM +0900, Boojin Kim wrote:
>>>> This patch uses LDRD/STRD that loads and stores data as DWORD unit
>>>> for the copy of 8-words data.
>>>> It brings better performance than LDRM/STRM that was used originally.
>>>
>>> And what about CPUs that don't have ldrd/strd ?
>>>
>>
>> And what about CPUs that do have ldrd/strd but is slower than ldm/stm?
>> I'm pretty sure that is almost everything currently out there.
> 
> The double-word load/stores were introduced in ARMv6.  Some Intel based
> CPUs prior to this have the support as well.  Everything else doesn't.
> 
> So taht's nowhere close to 'almost everything'.

I meant of all platforms that support both instructions, ldm/stm will be
faster than ldrd/strd on almost all of them AFAIK. I don't think the
claim about being faster is true for an CortexA9 or anything prior.
Linaro folks have done some benchmarking in this area and would be
better to comment.

Rob
