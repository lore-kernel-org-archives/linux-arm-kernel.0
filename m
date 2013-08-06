From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 05 Aug 2013 22:21:47 -0600
Subject: [PATCH v2] ARM: DT: binding fixup to align with
 vendor-prefixes.txt
In-Reply-To: <5200407A.4010407@broadcom.com>
References: <1375482479-15732-1-git-send-email-csd@broadcom.com>
 <51FFCC42.6040300@wwwdotorg.org> <5200407A.4010407@broadcom.com>
Message-ID: <520079DB.5090309@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/2013 06:16 PM, Christian Daudt wrote:
> On 13-08-05 09:01 AM, Stephen Warren wrote:
>> On 08/02/2013 04:27 PM, Christian Daudt wrote:
>>> [ this is a follow-up to this discussion:
>>> http://archive.arm.linux.org.uk/lurker/message/20130730.230827.a1ceb12a.en.html
>>> ]
>>> This patchset renames all uses of "bcm," name bindings to
>>> "brcm," as they were done prior to knowing that brcm had
>>> already been standardized as Broadcom vendor prefix
>>> (in Documentation/devicetree/bindings/vendor-prefixes.txt).
>>> This will not cause any churn on devices because none of
>>> these bindings have made it into production yet.
>>> Also rename the the following dt binding docs that had "bcm,"
>>> in their name for consistency:
>>>   - bcm,kona-sdhci.txt -> kona-sdhci.txt
>>>   - bcm,kona-timer.txt -> kona-timer.txt
>>> Changes since v1:
>>>   - added driver match table entries for deprecated names

>>> diff --git a/Documentation/devicetree/bindings/arm/bcm/bcm11351.txt
>>> b/Documentation/devicetree/bindings/arm/bcm/bcm11351.txt
>>> index fb7b5cd..cf1b206 100644
>>> --- a/Documentation/devicetree/bindings/arm/bcm/bcm11351.txt
>>> +++ b/Documentation/devicetree/bindings/arm/bcm/bcm11351.txt
>> I wonder if this patch should rename bindings/arm/bcm/ to
>> bindings/arm/brcm/ too?
>
> I'd rather keep it as-is - to me the vendor prefix is a DT concept only,
> and I'd rather not extend its tentacles into other parts of the kernel
> (and the other arm/ subtrees in there all show no attempt at
> dirname==vendor-prefix), but I'm ok with changing it to broadcom if you
> prefer.

Well, except that Documentation/devicetree/bindings is more part of DT
than the kernel, and there are active moves afoot to separate it out.

But, I suppose it's not a big deal; we can fix it when that happens I
suppose.

>>>   Required root node property:
>>>   -compatible = "bcm,bcm11351";
>>> +compatible = "brcm,bcm11351";
>> In a patch of mine that deprecated a property, Mark wondered if it would
>> make sense to mention the old deprecated DT content simply to document
>> that it existed, so that old DTs would still make sense when checking
>> the documentation. I wonder if the same argument applies to this patch?
>
> I would think the opposite. Deprecated items should be dropped from
> documentation. They are in the code (for a holdover period) but clearly
> marked as deprecated. No one should be extending the life of these, and
> adding documentation on it is a step in the wrong direction of making it
> easier for it to linger beyond what it should.

The deprecated stuff will have to be fully documented once the DT schema
validation is in place...
