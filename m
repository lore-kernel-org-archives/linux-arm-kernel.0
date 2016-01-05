From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 5 Jan 2016 15:52:40 -0700
Subject: Including Raspberry Pi -next trees in linux-next
In-Reply-To: <20160106093239.21848a48@canb.auug.org.au>
References: <87fuyozzax.fsf@eliezer.anholt.net>
 <87d1tfrdu0.fsf@eliezer.anholt.net> <568C2619.20705@wwwdotorg.org>
 <3082544.lZk2r7IkWv@wuerfel> <20160106093239.21848a48@canb.auug.org.au>
Message-ID: <568C4938.1010609@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/05/2016 03:32 PM, Stephen Rothwell wrote:
> Hi Eric,
>
> On Tue, 05 Jan 2016 22:26:33 +0100 Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> On Tuesday 05 January 2016 13:22:49 Stephen Warren wrote:
>>>>>>
>>>>>> branches:
>>>>>> drm-vc4-next
>>>>>> bcm2835-dt-next
>>>>>> bcm2835-soc-next
>>>>>> bcm2835-drivers-next
>>>>>> bcm2385-defconfig-next
>>>>>> (bcm2835-maintainers-next is a placeholder since we have nothing for it
>>>>>> this round)
>>>
>>> Typically maintainers merge everything together into a single "for-next"
>>> to maintain a reasonable set of branches. I guess it doesn't affect me
>>> so my opinion isn't too relevant though:-)
>>
>> In my experience the common for-next branch works best because
>> you can change the set of branches that get merged into it as
>> needed. If there are 6 branches today, it's quite likely that there
>> will be another one in the future and if only one branch gets
>> merged into for-next, you don't need to worry about updating the list.
>
> Certainly, that would be easier for me.  Though you may want to keep
> the drm-vc4-next branch separate since that get merged via a different
> tree (and can appear at a different point in my merge list).
>
> It does mean an extra step for you i.e. you would need to merge all the
> relevant branches into the single "for-next" branch, but that should
> not be too big an imposition.

FWIW, I almost always build/test the for-next branch rather than (or 
sometimes in addition to) the individual branches, and since I do so 
much with that branch, I use some scripts to automate generating it, and 
pushing all the branches to kernel.org. The Tegra version of those 
scripts is at:

> https://git.kernel.org/cgit/linux/kernel/git/tegra/maint-scripts.git/tree/

In particular, see merge-linux-tegra.sh and its configuration file 
tegra-branches.sh.dot. Also push-linux-tegra.sh does all the pushes.
