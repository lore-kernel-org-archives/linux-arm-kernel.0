From: airlied@gmail.com (Dave Airlie)
Date: Mon, 1 Jul 2013 10:40:56 +1000
Subject: [PATCH RFC 1/3] DRM: Armada: Add Armada DRM driver
In-Reply-To: <20130701001752.GL3353@n2100.arm.linux.org.uk>
References: <20130629225210.GF3353@n2100.arm.linux.org.uk>
 <E1Ut41C-0000wl-Ff@rmk-PC.arm.linux.org.uk>
 <20130630115941.GG18285@phenom.ffwll.local>
 <20130630125238.GH3353@n2100.arm.linux.org.uk>
 <CAPM=9tydcpP2-A6fnnHB873Nekj4HnxjraZ3TtRG3UF-Bqa6OQ@mail.gmail.com>
 <20130701001752.GL3353@n2100.arm.linux.org.uk>
Message-ID: <CAPM=9typ6tH-WUty+6N63R2woJu0CkZtgbEXGsW3hVZpC-UovA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 1, 2013 at 10:17 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jul 01, 2013 at 10:01:30AM +1000, Dave Airlie wrote:
>> OMG I'm working in a subsystem where stuff is being developed, with only
>> a few resources! I know my full time job isn't maintaining a 500,000
>> line subsystem,
>> and the sub maintainers and developers do a great job refactoring
>> where required.
>>
>> lots of other driver authors have made substantial changes to the drm core as
>> they've written drivers, you spot one bit of refactoring and its a
>> major shortcoming
>> of the entire subsystem and development community.
>>
>> how about instead of writing:
>> "However, at least I've taken the time to _think_ about what I'm doing
>> and realise that there _is_ scope here for the DRM core to improve,
>> rather than burying this stuff deep inside my driver like everyone else
>> has.  That's no reason to penalise patches from the "good guys" who think"
>>
>> you go with
>> "I noticed this piece of functionality could be refactored, here is a
>> patch adding them to
>> the core, does anyone think its a good idea?"
>>
>> As Daniel pointed out every driver submitted has refactored things,
>> even exynos did a
>> lot of work to be the first ARM driver we shipped, the DRM core
>> doesn't write itself and
>> I fully expect driver authors to be the ones that tell me what needs
>> refactoring, since
>> they are on the pointy end, but to state that you are the only person
>> ever to think about
>> things is frankly being a dick.
>>
>> Lets try for less dick, and more productive in future.
>
> And you can stick your dick back where you got it from David.  Really,
> your response is totally uncalled for.
>
> Let's try realising that I only have very limited time to put into this
> and unlike the other submitters who have been _paid_ to get their code
> sorted, this is being done purely for free - which means it's really
> low priority.  As you should already realise because I've stated already
> that I *really* don't care whether it gets into mainline or not.

Really not every driver maintainer is paid to submit their drivers, if
you'd any clue
you'd understand that you aren't special. We currently have a number of non-paid
maintainer drivers being submitted and worked on, via for one, gma500
is maintain
in spare time, the tegra driver isn't purely a work of paid
dedication, I maintain
5 drivers currently, and I certainly don't do all of that in my day
job. Keeping attitude off
this list is what I do, I don't care if you don't appreciate the work
put in by other developers
to the drm subsystem, but I do and I won't have someone come in here
saying "you guys
suck" when clearly they've no historical perspective and as such are
plainly trolling.

Yes the DRM has growing pains, yes there is a lots of legacy shit in
the way of making
things clean, yes writing a driver for SoC is more painful than
necessary, but overall
its a majorly moving target, 5 years ago DRM/KMS hadn't considered ARM, now its
probably most of what we have to consider.

> If you want stuff to be refactored in DRM, you need to find someone
> with more time to do it.

I pointed out I didn't want stuff refactored, I wanted a driver author
to suggest
possible refactorings with a patch to add the interfaces, and suggest its a
good idea.

Split the patch, one to add the additions to the core without changing
anything, then just
have your driver use them. If other driver writes want to use them they'll
figure it out, and maybe someone else will go around and clean up the other
drivers.

I'm really hoping the OLPC guys pick up this work and care enough to
merge it, if not,
its a bit of a waste.

Dave.
