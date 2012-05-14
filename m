From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 May 2012 20:13:23 +0000
Subject: [PATCH 1/4] ARM: clps711x: Used own subarch directory for
 store header file
In-Reply-To: <E1SU1SU-0003hN-FS.shc_work-mail-ru@f197.mail.ru>
References: <1337017571-16208-1-git-send-email-shc_work@mail.ru>
 <201205141846.12491.arnd@arndb.de>
 <E1SU1SU-0003hN-FS.shc_work-mail-ru@f197.mail.ru>
Message-ID: <201205142013.23667.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 May 2012, Alexander Shiyan wrote:
> Mon, 14 May 2012 18:46:12 +0000 ?? Arnd Bergmann <arnd@arndb.de>:
> > On Monday 14 May 2012, Alexander Shiyan wrote:
> ...
> > I've applied these patches to the clps711x/cleanup branch, but I'm
> > not too happy with the submission form.
> > 
> > Most patches were missing a useful description, which I've had to add
> > from looking at the contents. In the future I'd expect you to add such
> > a description yourself, ideally one that explains why you need such a
> > change, which is something that is not always obvious from the patch
> > itself.
> The main problem is that I very badly know English.
> I'll try to write in more detail later :)

Don't worry about the quality of the language. Any information is better
than no information here, and a lot of contributors to the kernel don't
write English very well.

> > A comment like "Patch created for arm-soc clps711x/cleanup branch."
> > is completely meaningless for the changeset description. It should
> > either go into the [PATCH 0/4] cover letter that git-format-patch
> > can create for you, or if you send only a single patch, you can put
> > it between the '---' line and the diffstat, so it appears in the
> > email but not in the changelog.
> I've recently been using git. Not yet studied all the features.
> Mean that the option "--compose" must be used for it. Right?

yes, or the --cover-letter option to 'git format-patch', followed
by manually editing the files before you send them out.

> > Finally, don't send patches just one at a time when you know that
> > you have more of them. It's annoying for me that I have to go back
> > to the same branch and merge it repeatedly when you do this. Better
> > send the entire series at once, or for longer ones, send a git
> > pull request.
> I understand that you do not want to frequently switch from one branch to another,
> but I do not quite understand the difference between the patch and pull-request.

A pull request tends to be less work for me than a patch, and if you
send many patches, it's more work than just one, but a pull request
is always the same amount of work (aside from reviewing, which has
to be done anyway).

The problem with sending multiple patch series (or pull requests) for the
same topic is mostly that it messes up the git history by creating extra
merge commits. The extra work for me is actually not all that much of a
problem.

> > I have not pulled the branches into the main next/cleanup branch,
> > so they are not yet scheduled for the next merge window (the earlier
> > two ones are). Let me know whether you have more patches for this series,
> > I'll put it in once you are done.
> Yes, there are two ready-made patch that I am willing to post it. I have a lot of other
> code for that platform, but not yet ready to give it to the kernel, because it requires
> more time to debug some things.

Ok. Just as a reminder, we are almost at the v3.5 merge window and I would prefer
to get patches earlier than this, so at some point in the next few days I'll just
stop taking more patches for 3.5 and everything after that will go into 3.6.

	Arnd
