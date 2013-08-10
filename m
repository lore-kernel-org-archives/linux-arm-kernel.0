From: csd@broadcom.com (Christian Daudt)
Date: Sat, 10 Aug 2013 12:56:40 -0700
Subject: [PATCH v2] ARM: DT: binding fixup to align with
 vendor-prefixes.txt
In-Reply-To: <52053FA7.5010809@wwwdotorg.org>
References: <1375482479-15732-1-git-send-email-csd@broadcom.com>
 <51FFCC42.6040300@wwwdotorg.org> <5200407A.4010407@broadcom.com>
 <520079DB.5090309@wwwdotorg.org> <52016D44.7060808@broadcom.com>
 <520514C4.5020007@wwwdotorg.org>
 <CAA-5wcDOv+ru+4QiDbEZr-SP90xHSh1bq+ifdVxOsOnid1komg@mail.gmail.com>
 <CAA-5wcAEUkX=n-WAi28JFUxQ44cuyUKW3b1PGVpukyqKRF9bDg@mail.gmail.com>
 <52053FA7.5010809@wwwdotorg.org>
Message-ID: <52069AF8.7040608@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-08-09 12:14 PM, Stephen Warren wrote:
> On 08/09/2013 12:49 PM, Christian Daudt wrote:
>> [resend in plain-text]
>>
>>
>> On 2013-08-09 9:11 AM, "Stephen Warren" <swarren@wwwdotorg.org> wrote:
>>> On 08/06/2013 03:40 PM, Christian Daudt wrote:
>>>> On 13-08-05 09:21 PM, Stephen Warren wrote:
>>>>>>>>     Required root node property:
>>>>>>>>     -compatible = "bcm,bcm11351";
>>>>>>>> +compatible = "brcm,bcm11351";
>>>>>>> In a patch of mine that deprecated a property, Mark wondered if it
>>>>>>> would
>>>>>>> make sense to mention the old deprecated DT content simply to document
>>>>>>> that it existed, so that old DTs would still make sense when checking
>>>>>>> the documentation. I wonder if the same argument applies to this patch?
>>>>>> I would think the opposite. Deprecated items should be dropped from
>>>>>> documentation. They are in the code (for a holdover period) but clearly
>>>>>> marked as deprecated. No one should be extending the life of these, and
>>>>>> adding documentation on it is a step in the wrong direction of making it
>>>>>> easier for it to linger beyond what it should.
>>>>> The deprecated stuff will have to be fully documented once the DT schema
>>>>> validation is in place...
>>>>>
>>>> This deprecated code should be short lived, given that in actual fact it
>>>> is actually quite unnecessary since no boards exist that rely on it.
>>> Is this patch for v3.11-rc* or v3.12?
>>>
>> I'm guessing it's too late for 3.11 at this point.
>>
>>> If it's for v3.12, then I see that v3.11 will be released with a variety
>>> of users of the old compatible values, hence the old compatible value is
>>> an ABI, and hence we should continue to support and document it (as
>>> deprecated).
>>>
>> I think whether bindings automatically become ABI at kernel release is
>> still an open topic. And as I mentioned in this case we are the only
>> ones affected and we don't have a problem with the change.
>> But if that's the case then there's no point to this patch. I'll just
>> add bcm to vendor-prefixes and be done with it.
>> I'm okay either way. Just need to know what direction to take asap so
>> I can stop telling devs to keep changing back and forth...
> I think it's fine to fix the issue; we should just do so in the trivial
> way that maintains backwards-compatibility, and allows people who
> compare the binding document to old DTs to understand how the correlate
> to each-other.
>
>
Ok,
  I've added indication that bcm, existed and is deprecated to the 
bindings documentation and resent the patch.

  Thanks,
    csd

PS: I will be mostly away from internet for next 8 days so responses 
will likely only happen after then.
