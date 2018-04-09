From: bhsharma@redhat.com (Bhupesh Sharma)
Date: Mon, 9 Apr 2018 09:31:34 +0530
Subject: [Query] ARM64 kaslr support - randomness, seeding and kdump
In-Reply-To: <20180406020948.GE19607@linaro.org>
References: <CACi5LpMhHt4bjEueOzHZTGpzuR2zoQqXcReL-khoSNLG6=FVmg@mail.gmail.com>
 <CAKv+Gu8qd=rpJkG_GoVO=kkmc4qx_zZD8c_wwE16gr=8wSShSw@mail.gmail.com>
 <20180313102158.GI25863@linaro.org>
 <20180313104715.prurmrizho4ddc4l@lakrids.cambridge.arm.com>
 <20180313110747.GJ25863@linaro.org>
 <20180313112016.ocx4qqhji3zfwjhs@lakrids.cambridge.arm.com>
 <CACi5LpN4DTYFVSVqru2j0y=CKr2ztrJ1gCW32sJBU=oUV2fcWw@mail.gmail.com>
 <20180314021050.GK25863@linaro.org>
 <20180314182448.bnvjtgyzipsuxcbe@lakrids.cambridge.arm.com>
 <CACi5LpNyx5VKO6mYB1yXNPENPKhAfAJ7cUSBeVzVtXfF6+EPwg@mail.gmail.com>
 <20180406020948.GE19607@linaro.org>
Message-ID: <CACi5LpPe_C0fLFzsAHPD54X=D+AsYjvSyZi0yt_6=wFrWmvetw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akashi,

On Fri, Apr 6, 2018 at 7:39 AM, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
> Bhupesh,
>
> On Fri, Mar 16, 2018 at 03:05:10PM +0530, Bhupesh Sharma wrote:
>> On Wed, Mar 14, 2018 at 11:54 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> > On Wed, Mar 14, 2018 at 11:10:53AM +0900, AKASHI Takahiro wrote:
>> >> If kaslr-seed has a critical value in terms of security, is kexec-tools
>> >> a right place? It is exposed to user space albeit for a short time of period.
>> >
>> > The kernel zeroes the seed in the DT at boot time, so the current seed
>> > isn't visible to userspace.
>> >
>> > If kexec-tools generates a seed, and inserts it into the DTB that it
>> > loads, this is only visible to kexec tools or other applications which
>> > can inspect its memory, so I don't think this is much of a concern.
>> > Anything with such privilege can presumably kexec() to arbitrary code
>> > anyhow.
>> >
>> > The next kernel will then zero its seed in the DT at boot time, so
>> > similarly this won't be visible to userspace on the new kernel.
>> >
>> > FWIW, having kexec tools generate a seed for the kexec_load() case makes
>> > sense to me.
>>
>> Fair enough. I will try to take a stab at the same and come back with
>> my findings on this thread.
>
> How's your progress here?

I am almost done with the implementation.
Unfortunately I lost most of the last week trying to revive my arm64
board (which supports
EFI_RNG_PROTOCOL and hence can be used to test the kaslr-seed related
stuff), so I was not
able to test the implementation.

Now that the board is up, I think I can test and thrash out any
missing clogs in the approach.

> I've already added kaslr support (i.e. "virtual randomisation") to
> my kexec_file patch set.
> # just a few lines of code, though

Hmm, have you sent out a new version already (kexec_file_load), as the last
version in my inbox still mentions in the cover letter that we need a
EFI stub like approach
to really support CONFIG_RANDOMIZE_BASE. Or, am I missing something?

I would love to have a look at the patch and try it at my end, so
could you please share
a pointer to the same.

Regards,
Bhupesh
