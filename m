From: fainelli@broadcom.com (Florian Fainelli)
Date: Fri, 23 Oct 2015 11:45:06 -0700
Subject: [GIT PULL 2/2] Broadcom SoC changes for v4.4 (part 2)
In-Reply-To: <20151023180238.GD18961@localhost>
References: <1445280190-8812-1-git-send-email-f.fainelli@gmail.com>
 <20151023180238.GD18961@localhost>
Message-ID: <562A8032.2060209@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/10/15 11:02, Olof Johansson wrote:
> Hi Florian,
> 
> On Mon, Oct 19, 2015 at 11:43:09AM -0700, Florian Fainelli wrote:
>> The following changes since commit c4a8ea9e0698945b182ba1e1063a0981b1f35139:
>>
>>   ARM: brcmstb: Setup BIU control registers during boot (2015-10-09 13:42:18 -0700)
>>
>> are available in the git repository at:
>>
>>   http://github.com/Broadcom/stblinux tags/arm-soc/for-4.4/soc-part2
>>
>> for you to fetch changes up to d0317a5d496dfac6d11e281d61b7aae0d4192e81:
>>
>>   ARM: bcm2835: Add the Raspberry Pi firmware driver (2015-10-19 11:08:40 -0700)
> 
> I see this merge window has been a touch confusing on the broadcom side, and we
> should probably have pointed this out sooner:
> 
> We normally prefer to separate out arch/arm/mach* changes as the usual soc
> changes, and keep drivers/soc and other drivers/* changes in separate branches,
> usually merged through our 'drivers' branch instead.

I will keep that in mind. I need to say it, because none of this seems
to be written anywhere, and having tribal knowledge like this is not
going to fly very long, but now that we know this, we'll hopefully get
better.

> 
> I don't see what's "SoC" about the patch in this branch, and I don't think it's
> dependent on the other contents in previous SoC branches. So let's merge this
> as a separate driver branch, if that's ok?

That is correct. See below for the merge.

> 
> In other words, please send a new pull request that contains this without the
> SoC base, and we'll merge it through our next/drivers. Or, if you prefer, I
> can cherry-pick it out myself. I'll leave the choice up to you and what works
> for you in your workflow.

I think there has been two issues mentioned to me by Eric and someone else:

- there is a bisection breakage (that's for the Device Tree changes)
- there is a missing include guard for a header introduced here

At this point, if it is not too late, I can re-do these two pull
requests, like right now, and get that sorted out.

Eric and I will figure out something that works as a proper workflow
process, and the Raspberry Pi SoCs will have to stop being special here.

Thank you.
-- 
Florian
