From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 7 Feb 2017 22:12:36 +0100
Subject: [GIT PULL 1/2] Broadcom dts changes for 4.11 (part 2)
In-Reply-To: <077dc1a1-7069-dd84-5f23-1f88420b05e5@gmail.com>
References: <20170202020607.31682-1-f.fainelli@gmail.com>
 <1912177.f24aWX6xy5@wuerfel>
 <077dc1a1-7069-dd84-5f23-1f88420b05e5@gmail.com>
Message-ID: <CAK8P3a2FtHbtvnzdf6UN2JxA4Uj34AW_bhD1TuBQJJbU5TdoVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 7, 2017 at 9:59 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 02/07/2017 06:49 AM, Arnd Bergmann wrote:
>> On Wednesday, February 1, 2017 6:06:07 PM CET Florian Fainelli wrote:
>>> Please note that because of the "clk" topic branch merged by Eric, we end-up with
>>> pulling in v4.10-rc2 which is responsible for the funny diff here.
>>
>> It's generally better to avoid those back-merges entirely, that is not
>> the only problem with them. Our DT branch is already based on -rc3,
>> so it's not a back-merged for me, and I think that's ok when I send
>> it upstream.
>>
>> However, I see that you do pull in these changes:
>>
>> Eric Anholt (5):
>>       clk: bcm2835: Don't rate change PLLs on behalf of DSI PLL dividers.
>>       clk: bcm2835: Register the DSI0/DSI1 pixel clocks.
>>       clk: bcm2835: Add leaf clock measurement support, disabled by default
>>
>> I'd rather not have those in next/dt at all, and at the very least
>> we require an explanation in the changelog about why you are sending
>> them to arm-soc. I assume that they are present in the clk-next
>> tree and won't get rebased, but that's not clear from your pull
>> request.
>
> OK, the explanation is provided in the merge commit, but I suppose I
> should have added this again to the pull request changelog.

Yes, more generally speaking, the pull request changelog (i.e. the tag
description) should give me enough information to decide whether to
merge it or not.

>> If you send the other changes again today, I'll pull them right away,
>> and then we can talk about what we do for the clk-bcm2835 changes.
>
> OK, let me try to sync up with Eric on this and see if we can come up
> with something better. A pull request based on v4.10-rc3 would be
> acceptable, right?

Yes, basing on -rc3 is fine. I think you pulled Eric's branch into yours
last, so if you just send the pull request without that merge, and without
rebasing, then we can take all other changes.

For the bcm2835, try coming up with a branch that doesn't need the
dependency and send that separately. There are three common ways
to do that:

- rebase the patches on top of the commit that introduced the header file
  change, provided that one sits directly on top of an -rc without any
  driver patches below it (or in the same patch)
- change the dts files to refer to the clk by numeric value instead of the
  macro name, then follow up with a patch to use the name for a later
  release
- defer the whole branch for the next kernel release.

    Arnd
