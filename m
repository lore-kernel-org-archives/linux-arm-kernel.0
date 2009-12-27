From: swetland@google.com (Brian Swetland)
Date: Sun, 27 Dec 2009 12:20:02 -0800
Subject: tree with htc dream support
In-Reply-To: <20091227201514.GA29174@elf.ucw.cz>
References: <20091205221100.GA32522@elf.ucw.cz>
	<1260054737.23633.35.camel@desktop>
	<a55d774e0912051638u7858878cg7cf62905c3c005c1@mail.gmail.com>
	<d6200be20912112142r7bdf8f18o31edd4457aa64998@mail.gmail.com>
	<1260627482.20913.7.camel@desktop>
	<d6200be20912121434x1a247837w75c518ba20fe684f@mail.gmail.com>
	<20091213212504.GD5114@elf.ucw.cz>
	<d6200be20912142234ia050c67p34fd2672e7248170@mail.gmail.com>
	<20091227093537.GD11737@elf.ucw.cz>
	<20091227201514.GA29174@elf.ucw.cz>
Message-ID: <a55d774e0912271220p1d102b1dr398e0524c9386702@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 27, 2009 at 12:15 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Sun 2009-12-27 10:35:38, Pavel Machek wrote:
>> Hi!
>>
>> > > One more wish list item: many drivers are now available in
>> > > drivers/staging/dream, and are being slowly cleaned up. Would it be
>> > > possible to start using those for android-msm-2.6.32 tree?
>> > >
>> > > You'll need to reapply some stuff I had to remove (like wakelocks),
>> > > but it should be still better/less work long term to patch those back
>> > > in than maintaining separate copy. Diff should get much smaller...
>> >
>> > I do plan to look at these, but I don't know when I'll get to it.
>>
>> So... this switches qdsp5 code from private version to version in
>> staging. It actually boots.
>
> And when I replace .c's in qdsp5 with -msm version, it also works,
> with diff being reasonably small.
>
> Now... how does camera driver work? I did not drivers/media/video/msm/
> driver into the kernel, but camera application seems to still
> work...?!

Depends which version of the camera userspace code you've got.  The
stuff for cupcake/donut talks directly to the DSP and the DSP
interacts with the VFE (video frontend, the camera data transport).  I
believe the new camera driver bypasses some (all?) of that and deals
with the VFE directly.  At least on 8k that's how it works (no DSP
involvement at all).

Brian
