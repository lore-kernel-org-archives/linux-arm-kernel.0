From: olof@lixom.net (Olof Johansson)
Date: Thu, 13 Sep 2012 00:42:07 -0700
Subject: [GIT PULL 2/4] mxs sparse-irq support
In-Reply-To: <20120913061557.GA3141@S2101-09.ap.freescale.net>
References: <1347350100-4674-1-git-send-email-shawn.guo@linaro.org>
 <1347350100-4674-3-git-send-email-shawn.guo@linaro.org>
 <20120913055647.GF24290@quad.lixom.net>
 <20120913061557.GA3141@S2101-09.ap.freescale.net>
Message-ID: <CAOesGMgKfRZG07ZBo57Xcjbq4hnfhDYzKF-F58mUsrpDRf3EwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2012 at 11:16 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Wed, Sep 12, 2012 at 10:56:47PM -0700, Olof Johansson wrote:
>> On Tue, Sep 11, 2012 at 03:54:57PM +0800, Shawn Guo wrote:
>> > The following changes since commit d9875690d9b89a866022ff49e3fcea892345ad92:
>> >
>> >   Linux 3.6-rc2 (2012-08-16 14:51:24 -0700)
>> >
>> > are available in the git repository at:
>> >
>> >   git://git.linaro.org/people/shawnguo/linux-2.6.git tags/mxs-sparse-irq
>> >
>> > for you to fetch changes up to 6608f13fabdb1f9ecbd502763ba33ca2646834c8:
>> >
>> >   ARM: mxs: remove mach/irqs.h (2012-09-03 09:32:17 +0800)
>> >
>> > ----------------------------------------------------------------
>> > mxs-sparse-irq
>> >
>> > The series adds irqdomain support for mach-mxs and then enables
>> > sparse-irq.  It dependes on pull request mxs-dt-3.7.
>>
>> Thanks, pulled in under next/soc2 due to the dt dependency.
>>
>> However, for the future: if you're truly dependent on the dt branch to
>> build/boot, you should use that as a base for this branch. Otherwise you
>> can end up in a state with git bisect where you only have this branch
>> applied but not the other one.
>>
> Ok.  That's actually a little bit easier for me, since I only need to
> send you the branch that I tested with.
>
> I got an impression that we should try hard to base pull-requests on
> -rc.  That said, we should only base one branch/pull-request on another
> when there is a dependency at file content level.  The build/boot level
> dependency can just be sorted out in arm-soc tree when the branch gets
> built into for-next or sent to Linus.

That was my stance in the past as well but once I got shown how git
bisect can end up in a state where only the later branch is included,
and not the prerequisite, it became obvious that for a bisectable
contents the branches indeed need to be based on each other. See
http://marc.info/?l=linux-kernel&m=133739202430250&w=2 for more info.

And that's fine, since if you base (in this case) the dt branch on an
-rc, and then the sparse-irq branch on top of the dt branch, the total
pull request is still based on an -rc. What we don't want is when
someone starts a new branch on a random mainline commit between two
-rcs.


-Olof
