From: robherring2@gmail.com (Rob Herring)
Date: Thu, 20 Oct 2011 12:09:03 -0500
Subject: [GIT PULL] GIC DT binding support
In-Reply-To: <201110201812.29202.arnd@arndb.de>
References: <4E97A601.1020005@gmail.com> <201110201507.38722.arnd@arndb.de>
	<4EA03160.1050304@gmail.com> <201110201812.29202.arnd@arndb.de>
Message-ID: <4EA055AF.4030207@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/20/2011 11:12 AM, Arnd Bergmann wrote:
> On Thursday 20 October 2011, Rob Herring wrote:
>> Arnd,
>>
>> On 10/20/2011 08:07 AM, Arnd Bergmann wrote:
>>> On Friday 14 October 2011, Rob Herring wrote:
>>>> Please pull GIC device tree support. This is the first of 2 pull
>>>> requests. You can ignore this one if there are no other dependencies on
>>>> GIC DT support.
>>>>
>>>> This is based on rmk's for-next branch and v3.1-rc9. rc9 was needed for
>>>> this dependency:
>>>
>>> I don't see the for-next branch in the history. Do you mean it requires
>>> the for-next branch as well in order to actually build?
>>
>> Probably because it is buried by rc9 commits:
>>
>> git log v3.1-rc9..gic-dt
> 
> Ah, I see them now. I should make sure I look more closely next time.
> That definitely explains why I couldn't get this to merge into my
> for-next branch cleanly.
> 
>>> Can you be more specific so I can watch for the dependencies to
>>> get upstream first?
>>>
>>
>> I believe it conflicts with this commit in rmk/for-next:
>>
>> commit b166bc3be08b744d2f4b14921a1efee14906b383
>> Author: Will Deacon <will.deacon@arm.com>
>> Date:   Tue Aug 23 22:20:03 2011 +0100
>>
>>     ARM: 7061/1: gic: convert logical CPU numbers into physical numbers
>>
>> And this one in rmk/devel-stable:
>>
>> commit 254056f3b12563c11e6dbcfad2fbfce20a4f3302
>> Author: Colin Cross <ccross@android.com>
>> Date:   Thu Feb 10 12:54:10 2011 -0800
>>
>>     ARM: gic: Use cpu pm notifiers to save gic state
>>
> 
> Ok. Conflicts are not the problem though, I can handle them and sfr can
> handle them for linux-next, too. Real dependencies are the problem,
> where you rely on a feature that is part of another tree.
> 
>> BTW, Russell's for-next branch has been rebased. The conflict with the
>> 1st commit is trivial, so I could rebase to merge of rmk/devel-stable
>> and v3.1-rc9.
>>
>> I still need things from for-next for highbank. So perhaps I should send
>> a pull request after Russell's tree goes in?
> 
> Yes and no. You simply cannot ask me to merge a branch that is based on
> top of Russell's for-next branch, since that is getting rebased. It is
> also bad if the stuff doesn't have any linux-next exposure, so we should
> try to find another way out.
> 
> I've now rebased your tree on top of 3.1-rc9 plus the stable branches
> from Russell's tree that I already have as dependencies in arm-soc/for-next
> (devel-stable, smp, debug). This has caused no conflicts for me, but
> that doesn't mean that it's correct. Please check that what I have
> in arm-soc/dt/gic and arm-soc/highbank/soc actually works for you
> and does not contain branches that you don't actually need.
> 

dt/gic doesn't need Russell's debug branch, but highbank does.

highbank/soc doesn't build. It needs Russell's l2x0 and io branches.
l2x0 has been rebased recently, but the io branch seems to be stable
(but not published externally).

Rob
