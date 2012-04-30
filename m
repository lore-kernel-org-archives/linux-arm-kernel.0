From: arnd.bergmann@linaro.org (Arnd Bergmann)
Date: Mon, 30 Apr 2012 14:41:39 +0000
Subject: announcing the clk-next branch
In-Reply-To: <4F98C780.8020309@st.com>
References: <CAJOA=zOGSh3et4nxE=JdojL4uDjgt8o+oiOU4pmbM=oU2U6prA@mail.gmail.com>
 <4F98C780.8020309@st.com>
Message-ID: <201204301441.39191.arnd.bergmann@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 26 April 2012, Viresh Kumar wrote:
> I want to understand a bit about how these patches go to linux-next.
> Mike would be sleeping right now, so will not disturb him ;)
> 
> Arnd,
> 
> Can you please help?
> 
> Just like Mike, you also asked me to base my patches on an rc release.
> Now, few of the dependency patches are there in linux-next that i would need.
> Some under my authorship, and some from others. And this number can be 30-50.
> 
> Should i ask Mike to apply all of them first and then my patches OR do that
> myself and send a pull request. Which would mean all patches, that weren't
> related to my patchset also get pushed through my branch. Isn't that a problem?

Sorry for the late reply on my side. I'm not sure if I understand your
question correctly. Generally the rule is to not apply the same patch to
two separate branches because that can result in merge conflicts and/or an
unclean history.

The way to deal with dependencies in a case like this is to apply the patches
on one branch in the right order and ask different people to include parts of
that branch in their trees without rebasing.

For instance, you can take Mike's branch as a base (as long as he promises
to never rebase that branch), add some patches on top and ask him to pull that
commit with your additional clk patches. Then you add other patches for arm-soc
on top of that and ask me to pull that branch, including the clk commits that
originally came from Mike.

I can then pull the branch into one of the arm-soc branches that gets sent to
Linus after the clk tree was merged into v3.5-rc1.

It also works the other way round: You can base on top of patches that are
already in arm-soc, add more stuff that should go into arm-soc on top, and
add clk patches for Mike on top of that, which means that in the end, the
arm-soc tree has to go to Linus before the clk tree does.

The tricky part here is to avoid circular dependencies.

	Arnd
