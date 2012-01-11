From: olof@lixom.net (Olof Johansson)
Date: Tue, 10 Jan 2012 16:11:26 -0800
Subject: [GIT PULL] Samsung devel for v3.3
In-Reply-To: <20120110223712.GL7164@opensource.wolfsonmicro.com>
References: <018801ccca70$25f01260$71d03720$%kim@samsung.com>
 <alpine.LFD.2.02.1201101341040.2722@xanadu.home>
 <20120110184643.GF7164@opensource.wolfsonmicro.com>
 <201201102013.54958.arnd@arndb.de>
 <20120110223712.GL7164@opensource.wolfsonmicro.com>
Message-ID: <CAOesGMhDS+7O7LFB9CsbCeZs18S9r6YV-SeWF6hHXfRFVMNWhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 10, 2012 at 2:37 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Jan 10, 2012 at 08:13:54PM +0000, Arnd Bergmann wrote:
>> On Tuesday 10 January 2012, Mark Brown wrote:
>
>> > That sounds like it'd be helpful overall but it's something that has to
>> > be sorted out at the maintainer level. ?I'm guessing there's not really
>> > much that contributors can do here?
>
>> I think you did everything as good as you could, we just need to routinely
>> call for everyone to submit stuff in time. A number of maintainers sent stuff
>> after Christmas (which I expected to start the merge window) and were mostly
>> lucky because Linus gave us an extra 10 days to sort things out.
>
> I guess it would also be useful to have some way to compare what's in
> -next with what's in the arm-soc tree and chase people if that diff gets
> big. ?I do also wonder if it's worth letting people push stuff to you
> more aggressively - right now you seem to be asking people to batch
> things up and I wonder if that's making it a it easier for things to end
> up dropping on the floor if a time based routine isn't working well for
> people.

I actually did just this today based on this discussion, and I'll do
it through the next staging cycle to keep a track of the "arm backlog"
of how much is sitting in maintainer trees vs what has already been
merged into Russell's tree or arm-soc. We can include these stats in
next rounds "last call for patches" email to help catch forgotten
branches.

I merged rmk's for-next branch with the arm-soc one, merged that on
top of mainline and diffed arch/arm with what is in linux-next.

Right now, plus or minus some sloppy merge conflict resolutions on my
part, the statistics are:

git diff --stat next/master -- arch/arm
[..]
 113 files changed, 670 insertions(+), 810 deletions(-)

(this diffstat does not include late/* branches since they got
included in the arm-soc side of the diff)

Most of these are rightfully still there; some changes are going
through other trees such as some PCI changes, ASoC, PM, a few fixes
that haven't been sent up to arm-soc yet, etc.  A couple of patches
seem to have been queued in for-3.4 branches a bit early (Stephen
doesn't generally want people to start queueing new stuff until the
merge window is over), but that's just a couple of them.

So, it looks like there's no major backlog left for any specific vendor subtree.

>> end, samsung also did for the most part but not entirely and you were
>> unfortunate to be the contributor of the patches that missed out.
>
> It's not just me, I'm just vocal and perhaps more to the point spend a
> reasonable amount of time chasing stuff into various trees so want to
> figure out if I need to change what I'm doing with that.

What I would do myself is that if I hadn't seen the patches land in
the topmost staging tree by -rc6 or -rc7, I would ping the owner of
the tree that the patches are sitting in to make sure they go up.
Hopefully this kind of thing will be a rare scenario.


-Olof
