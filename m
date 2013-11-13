From: acourbot@nvidia.com (Alex Courbot)
Date: Wed, 13 Nov 2013 11:14:00 +0900
Subject: [PATCH v10 0/7] ARM: support for Trusted Foundations secure
 monitor
In-Reply-To: <CAOesGMhatp9ZQr=eTCtQ_9a_E9LXKdTCzJd+P7Sy9Ut9wtvnsA@mail.gmail.com>
References: <1383819106-1400-1-git-send-email-acourbot@nvidia.com>	<52828EF5.6090909@wwwdotorg.org>
 <CAOesGMhatp9ZQr=eTCtQ_9a_E9LXKdTCzJd+P7Sy9Ut9wtvnsA@mail.gmail.com>
Message-ID: <5282E068.1070608@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/13/2013 05:38 AM, Olof Johansson wrote:
> On Tue, Nov 12, 2013 at 12:26 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 11/07/2013 03:11 AM, Alexandre Courbot wrote:
>>> Just a set of small fixes to address the concerns expressed on v9 with the
>>> non-prefixed version DT properties. I hope there won't be a need for an
>>> eleventh (!) version. :P
>>
>> BTW, this version looks fine to me. On IRC, Olof said it looked OK to
>> him. I'm just waiting to hear back from Olof/Russell whether I should
>> merge this through the Tegra tree, or whether the first 1-3 patches
>> should go through Russell's tree.
>
> I pinged Russell, and he brought up the fact that there were earlier
> requests to move it to drivers/firmware. It would make sense to try to
> get that done before merging, especially if you anticipate someone
> using TF on 64-bit platforms.

IIRC when we discussed this point your last comment was as follows:

On Tue, Oct 29, 2013 at 6:55 AM, Olof Johansson <olof@lixom.net> wrote:
 > I think we can probably merge this under arch/arm now, and when we
 > figure out what needs to be common with ARM64 we can move it out to a
 > good location. It might be that mostly just a header file with ABI
 > conventions needs to be shared, not actual implementation, for
 > example.

So I thought we agreed on that. If in the end we prefer to move the ARM 
firmware interface into drivers/firmware, I'm fine with that too (Tomasz 
also confirmed he would be ok with it) but I wonder if that would not be 
somehow premature.

Another worry of mine is that this might delay this patchset some more. 
Support for TF is one of the last remaining step towards making NVIDIA 
branded Tegra retail devices (SHIELD and TegraNote at the moment) run 
upstream directly. I missed 3.13, I'd like to make sure I won't miss 
3.14. Would it be acceptable if we move the ARM firmware interface to a 
common place after this patchset is merged?
