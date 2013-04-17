From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 17 Apr 2013 19:45:40 +0530
Subject: [GIT PULL 2/3] ARM: davinci: SoC updates for v3.10 (part 2)
In-Reply-To: <20130416164838.GE4918@quad.lixom.net>
References: <1366046599-6590-1-git-send-email-nsekhar@ti.com>
 <1366046599-6590-2-git-send-email-nsekhar@ti.com>
 <20130415201835.GA24600@quad.lixom.net> <516CEBCF.60507@ti.com>
 <20130416164838.GE4918@quad.lixom.net>
Message-ID: <516EAE8C.1070204@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 4/16/2013 10:18 PM, Olof Johansson wrote:
> On Tue, Apr 16, 2013 at 11:42:31AM +0530, Sekhar Nori wrote:
>> On 4/16/2013 1:48 AM, Olof Johansson wrote:
>>> On Mon, Apr 15, 2013 at 10:53:18PM +0530, Sekhar Nori wrote:
>>>> Hi Arnd, Olof,
>>>>
>>>> Can you please the following SoC updates for DaVinci.
>>>> The branch depends on (and merges) an immutable branch
>>>> from Ohad adding DA8XX rempote proc driver.
>>>
>>> Hi,
>>>
>>> Where is this branch from? Git URL and branch name, please -- we prefer to pull
>>> these in as separate branches under depends/* as well to document it.
>>
>> Here is the repo and branch:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/ohad/remoteproc.git for-next
> 
> Oh! Looking at that branch, and the new branch from you, I don't actually see
> a dependency between them. Sure, the Davinci mach-side code registers a new
> device, but until the driver has the corresponding changes, there's no breakage
> caused by the new registration. There are no new data structures introduced
> either, so there's no build-time dependency added.

That's right! I can swear there was some platform data that the driver
needed at some stage which caused the dependency. Whatever that was, its
gone now (and I failed to notice it) so there is no real need of merging
the remoteproc branch.

> So it would be just as easy to just merge this as a nondependent branch. When
> both sides of the change land, remoteproc will work. But until then, nothing
> existing will be broken.
> 
> Sound ok? If so, please just rebase your 4 patches on top of the old SoC branch
> without the dependency and send a fresh pull request, please. :)

Okay, I will rebase and send updated pull request. I will have to update
the board support pull request too.

Thanks,
Sekhar
