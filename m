From: robherring2@gmail.com (Rob Herring)
Date: Thu, 20 Oct 2011 09:34:08 -0500
Subject: [GIT PULL] GIC DT binding support
In-Reply-To: <201110201507.38722.arnd@arndb.de>
References: <4E97A601.1020005@gmail.com> <201110201507.38722.arnd@arndb.de>
Message-ID: <4EA03160.1050304@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On 10/20/2011 08:07 AM, Arnd Bergmann wrote:
> On Friday 14 October 2011, Rob Herring wrote:
>> Please pull GIC device tree support. This is the first of 2 pull
>> requests. You can ignore this one if there are no other dependencies on
>> GIC DT support.
>>
>> This is based on rmk's for-next branch and v3.1-rc9. rc9 was needed for
>> this dependency:
> 
> I don't see the for-next branch in the history. Do you mean it requires
> the for-next branch as well in order to actually build?

Probably because it is buried by rc9 commits:

git log v3.1-rc9..gic-dt

> 
> Can you be more specific so I can watch for the dependencies to
> get upstream first?
> 

I believe it conflicts with this commit in rmk/for-next:

commit b166bc3be08b744d2f4b14921a1efee14906b383
Author: Will Deacon <will.deacon@arm.com>
Date:   Tue Aug 23 22:20:03 2011 +0100

    ARM: 7061/1: gic: convert logical CPU numbers into physical numbers

And this one in rmk/devel-stable:

commit 254056f3b12563c11e6dbcfad2fbfce20a4f3302
Author: Colin Cross <ccross@android.com>
Date:   Thu Feb 10 12:54:10 2011 -0800

    ARM: gic: Use cpu pm notifiers to save gic state


BTW, Russell's for-next branch has been rebased. The conflict with the
1st commit is trivial, so I could rebase to merge of rmk/devel-stable
and v3.1-rc9.

I still need things from for-next for highbank. So perhaps I should send
a pull request after Russell's tree goes in?

Rob
