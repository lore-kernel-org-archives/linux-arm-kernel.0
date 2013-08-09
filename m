From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 09 Aug 2013 10:11:48 -0600
Subject: [PATCH v2] ARM: DT: binding fixup to align with
 vendor-prefixes.txt
In-Reply-To: <52016D44.7060808@broadcom.com>
References: <1375482479-15732-1-git-send-email-csd@broadcom.com>
 <51FFCC42.6040300@wwwdotorg.org> <5200407A.4010407@broadcom.com>
 <520079DB.5090309@wwwdotorg.org> <52016D44.7060808@broadcom.com>
Message-ID: <520514C4.5020007@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/2013 03:40 PM, Christian Daudt wrote:
> On 13-08-05 09:21 PM, Stephen Warren wrote:
>>>>>    Required root node property:
>>>>>    -compatible = "bcm,bcm11351";
>>>>> +compatible = "brcm,bcm11351";
>>>> In a patch of mine that deprecated a property, Mark wondered if it
>>>> would
>>>> make sense to mention the old deprecated DT content simply to document
>>>> that it existed, so that old DTs would still make sense when checking
>>>> the documentation. I wonder if the same argument applies to this patch?
>>> I would think the opposite. Deprecated items should be dropped from
>>> documentation. They are in the code (for a holdover period) but clearly
>>> marked as deprecated. No one should be extending the life of these, and
>>> adding documentation on it is a step in the wrong direction of making it
>>> easier for it to linger beyond what it should.
>> The deprecated stuff will have to be fully documented once the DT schema
>> validation is in place...
>>
> This deprecated code should be short lived, given that in actual fact it
> is actually quite unnecessary since no boards exist that rely on it.

Is this patch for v3.11-rc* or v3.12?

If it's for v3.12, then I see that v3.11 will be released with a variety
of users of the old compatible values, hence the old compatible value is
an ABI, and hence we should continue to support and document it (as
deprecated).

>From v3.11-rc4:
> arch/arm/boot/dts/bcm11351-brt.dts:20:	compatible = "bcm,bcm11351-brt", "bcm,bcm11351";
> arch/arm/boot/dts/bcm11351.dtsi:21:	compatible = "bcm,bcm11351";
> arch/arm/boot/dts/bcm11351.dtsi:38:		compatible = "bcm,bcm11351-smc", "bcm,kona-smc";
> arch/arm/boot/dts/bcm11351.dtsi:43:		compatible = "bcm,bcm11351-dw-apb-uart", "snps,dw-apb-uart";
> arch/arm/boot/dts/bcm11351.dtsi:53:		compatible = "bcm,bcm11351-a2-pl310-cache";

While I admit that some bindings perhaps should be considered
unstable/experimental, I don't think that would apply here, since it's
simply a rename of an existing sane property value. Other DT maintainers
feel free to chime in if you disagree though.

If the patch is applied for v3.11-rc*, I think it'd be fine since the
old binding would never have been in a released kernel. But, I think
it's far too late in the rc cycle to apply this kind of change.
