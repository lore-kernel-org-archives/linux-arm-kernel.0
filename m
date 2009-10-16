From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 16 Oct 2009 11:01:31 +0800
Subject: spitz: add gpio button support (fixes regression)
In-Reply-To: <20091015215215.GG15898@elf.ucw.cz>
References: <20091006074635.GA2775@ucw.cz> <20091007085806.GB28807@elf.ucw.cz>
	<1254914991.4213.80.camel@hammer.suse.cz>
	<20091007120643.GA17069@rakim.wolfsonmicro.main>
	<f17812d70910070727x47b2a22h8e9f9304740d5abf@mail.gmail.com>
	<20091006200933.GA1606@ucw.cz> <1255641385.3985.55.camel@utx.utx.cz>
	<20091015212024.GC15898@elf.ucw.cz>
	<1255643252.3985.63.camel@utx.utx.cz>
	<20091015215215.GG15898@elf.ucw.cz>
Message-ID: <f17812d70910152001r7b5b0326s5f0e880cca3b3b68@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 16, 2009 at 5:52 AM, Pavel Machek <pavel@ucw.cz> wrote:
> On Thu 2009-10-15 23:47:32, Stanislav Brabec wrote:
>> Pavel Machek wrote:
>> >Well, resume is hit by second regression.
>> >
>> >Suspend key.... I restored it to the level of functionality in
>> >2.6.31 :-).
>>
>> > > + ? ? ? ? .type ? = EV_KEY,
>> > > + ? ? ? ? .code ? = KEY_SUSPEND,
>>
>> I guess it should be EV_PWR. Then it will at least go to suspend.
>
> Does it actually go to suspend with that change?
>
> (Actually, I wonder how it could have ever worked: userspace should
> certainly be in a loop there; kernel should not suspend machine on its
> own. In -rp kernels, kernel _does_ suspend on its own, but... I'm not
> sure if that's suitable for mainline).

EV_PWR is what's in the original spitzkbd.c, so I assume that's
something we should keep. And the reason that EV_PWR makes
it actually suspend might related the APM emulation things,
which I'm not very sure about.
