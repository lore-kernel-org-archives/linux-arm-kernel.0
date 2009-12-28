From: swetland@google.com (Brian Swetland)
Date: Mon, 28 Dec 2009 12:24:20 -0800
Subject: tree with htc dream support
In-Reply-To: <20091227101824.GB1478@ucw.cz>
References: <1260627482.20913.7.camel@desktop>
	<20091213212504.GD5114@elf.ucw.cz>
	<d6200be20912142234ia050c67p34fd2672e7248170@mail.gmail.com>
	<20091227093537.GD11737@elf.ucw.cz>
	<20091227201514.GA29174@elf.ucw.cz>
	<a55d774e0912271220p1d102b1dr398e0524c9386702@mail.gmail.com>
	<20091227203704.GK11737@elf.ucw.cz>
	<20091227211322.GB29174@elf.ucw.cz>
	<a55d774e0912271646m1b82687cy427083e64e91e323@mail.gmail.com>
	<20091227101824.GB1478@ucw.cz>
Message-ID: <a55d774e0912281224y7360dfdbu8a251743026bdd28@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 27, 2009 at 2:18 AM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> > Switch smd code to the version in staging. Something to apply to
>> > dream/ tree I'd say... and yes, it still works.
>>
>> I think we might want to consider leaving at least the core smd code
>> under mach-msm.
>
> In the long run, I agree.
>
> In the short run... the code is staging quality, so it should be in
> staging... and you'll not have to mainain so huge diff. (-20 kLoc).

The core smd stuff is really not that large.  The central smd.[ch] are
about 1300 lines, and proc_comm.[ch] are about 400 lines.  Is it
possible to get some review/feedback as to what's "staging quality"
about this code so we can clean it up?  I'd rather just fix the issues
and get the core stuff in there so clock, power, etc support is there
for the platform rather than have it live in staging purgatory.

Since this stuff is integral to mach-msm, required for essential
operation of the platform, and makes sense to be part of the mach-msm
codebase, why not just fix it there rather than move it out into
staging and then back?  I'm not sure what that gains us.

Brian
