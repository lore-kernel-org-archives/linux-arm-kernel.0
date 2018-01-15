From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 15 Jan 2018 14:10:11 +0100
Subject: [GIT PULL] updates to soc/fsl drivers for v4.16
In-Reply-To: <AM4PR0401MB1699179D81FBB37456325AEA8F170@AM4PR0401MB1699.eurprd04.prod.outlook.com>
References: <1515628596-4715-1-git-send-email-leoyang.li@nxp.com>
 <20180112020217.tqdjt3voqimr3ptx@localhost>
 <AM4PR0401MB1699179D81FBB37456325AEA8F170@AM4PR0401MB1699.eurprd04.prod.outlook.com>
Message-ID: <CAK8P3a3d8VeYk=3p=hF1_==MRLXWwW4bbOZnv0y62BcoEg2-1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 12, 2018 at 8:28 PM, Leo Li <leoyang.li@nxp.com> wrote:
>> -----Original Message-----
>> From: Olof Johansson [mailto:olof at lixom.net]
>> Sent: Thursday, January 11, 2018 8:02 PM
>> To: Leo Li <leoyang.li@nxp.com>
>> Cc: arm at kernel.org; shawnguo at kernel.org; linux-arm-
>> kernel at lists.infradead.org
>> Subject: Re: [GIT PULL] updates to soc/fsl drivers for v4.16
>>
>> On Wed, Jan 10, 2018 at 05:56:36PM -0600, Li Yang wrote:
>> > Hi arm-soc maintainer,
>> >
>> > Please merge the following tag to get updates to the soc/fsl/guts
>> > driver for support of additional SoCs and more error path handling.
>> >
>> > Thanks,
>> > Leo
>> >
>> >
>> > The following changes since commit
>> b2cd1df66037e7c4697c7e40496bf7e4a5e16a2d:
>> >
>> >   Linux 4.15-rc7 (2018-01-07 14:22:41 -0800)
>> >
>> > are available in the git repository at:
>> >
>> >   git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git
>> > tags/soc-fsl-for-4.16
>> >
>> > for you to fetch changes up to
>> 00ce0a2304014c73c2b7915215c7b3c73e2a25aa:
>> >
>> >   soc: fsl: guts: Add a NULL check for devm_kasprintf() (2018-01-10
>> > 16:54:26 -0600)
>>
>> 1) This is based on much too new a release
>
> The branch was created and the first patch was applied quite a while ago.  The
> second patch is relatively new but very straightforward.  I rebased the branch to
> -rc7 just before sending the pull request thinking it would be easier for you to
> merge.  If that is not a preferred action, I will not do that again in the future.

The general rule is to base on top of -rc1, unless you have a dependency on
a patch that went into a later -rc. Going to some -rc that is already part of
arm-soc is generally fine, but if you send a branch based on a later -rc
than ours, it messes up the git history unnecessarily, and it means that
whatever you send has seen less testing than what you had before the
rebase.

>> 2) the fact that it's based on this new a release makes me suspect it hasn't
>>    been sitting in linux-next either, at least not since before -rc7.
>
> My tree is not being merged by the Linux-next right now.  So you think we should ask Linux-next to add my tree too?

It's not mandatory, but most of our downstream trees are part of linux-next.

>> Conclusion: Please resend post merge window and we'll queue it up for the
>> next release. If the bugfix should go in sooner than that, I can cherry-pick
>> that into our fixes. Let me know.
>
> I know the pull request is coming a little bit late.  But the two small patches are really simple and straightforward.  They are not technically a fix but it will be really helpful if you can take it in this merge window.  And going forward, what is your preferred time frame to send pull request to for-next?

Send them as soon as you think the code is ready. In general, earlier is better,
even if you are still testing or expect that you may need additional patches
on top. If you send a large chunk of changes during -rc2 and then later (rc6 or
rc7) have some fixes to address issues you found with those, we're much
happier than when we don't hear anything until -rc6 and then get the larger
set of patches with more testing.

If you can find the old commit before your rebase (using 'git reflog')
then please
send that one so we can reconsider. If you can't find it, just send
the two patches
directly. Also, anything that is a real bugfix can of course get
merged any time.

      Arnd
