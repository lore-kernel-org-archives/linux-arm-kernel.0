From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 19 Nov 2012 11:36:24 +0200
Subject: [RFC] fbdev: arm has __raw I/O accessors, use them in fb.h
In-Reply-To: <20121119091504.GB3290@n2100.arm.linux.org.uk>
References: <1353057364-21214-1-git-send-email-archit@ti.com>
 <ADE657CA350FB648AAC2C43247A983F00206B2644F3F@AUSP01VMBX24.collaborationhost.net>
 <50A9C1C4.5070907@ti.com> <20121119091504.GB3290@n2100.arm.linux.org.uk>
Message-ID: <50A9FD98.1060105@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-11-19 11:15, Russell King - ARM Linux wrote:
> On Mon, Nov 19, 2012 at 10:51:08AM +0530, Archit Taneja wrote:
>> On Friday 16 November 2012 10:14 PM, H Hartley Sweeten wrote:
>>> On Friday, November 16, 2012 2:16 AM, Archit Taneja wrote:
>>>>
>>>> This removes the sparse warnings on arm platforms:
>>>>
>>>> warning: cast removes address space of expression
>>>>
>>>> Signed-off-by: Archit Taneja <archit@ti.com>
>>>
>>> I submitted the same patch around early March 2012. So FWIW:
>>>
>>> Reviewed-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>>
>> Thanks.
>>
>> Florian,
>>
>> Could you queue this for 3.8 merge window?
> 
> Actually no.  Has anyone checked whether this has any impact for the BE
> ARM platforms?

Probably not. I can't say anything to that matter, but I wonder if this
patch is just going around the problem that we get sparse warnings when
falling into the else ifdef block in fb.h.

The macros in the else block are defined as:

#define fb_readb(addr) (*(volatile u8 *) (addr))                                 

And fb code passes a pointer to __iomem. So shouldn't the cast be to
(volatile u8 __iomem *)?

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 897 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121119/c54a0a5f/attachment.sig>
