From: csd@broadcom.com (Christian Daudt)
Date: Fri, 2 Aug 2013 14:42:46 -0700
Subject: [PATCH] ARM: DT: binding fixup to align with vendor-prefixes.txt
In-Reply-To: <51FC262E.6090706@wwwdotorg.org>
References: <1375478278-22757-1-git-send-email-csd@broadcom.com>
 <51FC262E.6090706@wwwdotorg.org>
Message-ID: <51FC27D6.8050607@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 13-08-02 02:35 PM, Stephen Warren wrote:
> On 08/02/2013 03:17 PM, Christian Daudt wrote:
>> [ this is a follow-up to this discussion:
>> http://archive.arm.linux.org.uk/lurker/message/20130730.230827.a1ceb12a.en.html ]
>> This patchset renames all uses of "bcm," name bindings to
>> "brcm," as they were done prior to knowing that brcm had
>> already been standardized as Broadcom vendor prefix
>> (in Documentation/devicetree/bindings/vendor-prefixes.txt).
>> This will not cause any churn on devices because none of
>> these bindings have made it into production yet.
>> Also rename the the following dt binding docs that had "bcm,"
>> in their name for consistency:
>>   - bcm,kona-sdhci.txt -> kona-sdhci.txt
>>   - bcm,kona-timer.txt -> kona-timer.txt
> Using "git format-patch -M" for renames would make it much easier to see
> that all that's happening is a file rename and/or whatever other diff is
> happening.
ok
> I'd actually prefer to go the other way on the file renaming, and name
> all binding files after the complete compatible value they describe,
> rather than removing the vendor prefix on some files. But, I don't feel
> strongly for files I don't directly own.
ok, I'll leave without then. Less chance of future churn :)
> Technically this change shouldn't be made since it's an incompatible
> change to the DT ABI, unless you keep all the old entries in the
> driver's match tables and just add the new entries rather than deleting
> the old ones. If you do that, it should be enough to placate anyone
> adamantly opposed to this change, I think.
>
Done.
  Thanks for the quick review !

  csd
