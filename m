From: jean.pihet@linaro.org (Jean Pihet)
Date: Wed, 7 May 2014 12:14:18 +0200
Subject: [PATCH 3/3] perf tools: Add libdw DWARF post unwind support for
 ARM
In-Reply-To: <20140507100054.GD18456@arm.com>
References: <1399389979-11279-1-git-send-email-jean.pihet@linaro.org>
 <1399389979-11279-4-git-send-email-jean.pihet@linaro.org>
 <20140506175616.GH13677@arm.com>
 <CAFrcx1=aS+dmM05Zk_ioL_0vE+ot+9=LJ=WsmExRtDyZgMtetA@mail.gmail.com>
 <20140507100054.GD18456@arm.com>
Message-ID: <CAFrcx1mkE-N+DYUe0ZK06_BL1tsZvmyMHpAynnFkgZBqjghE5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 May 2014 12:00, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, May 07, 2014 at 10:52:05AM +0100, Jean Pihet wrote:
>> On 6 May 2014 19:56, Will Deacon <will.deacon@arm.com> wrote:
>> > On Tue, May 06, 2014 at 04:26:19PM +0100, Jean Pihet wrote:
>> >> Adding libdw DWARF post unwind support, which is part
>> >> of elfutils-devel/libdw-dev package from version 0.158.
>> >>
>> >> The new code is contained in unwin-libdw.c object, and
>> >> implements unwind__get_entries unwind interface function.
>> >
>> >   Reviewed-by: Will Deacon <will.deacon@arm.com>
>>
>> Ok, thx!
>>
>> Jiri, Arnaldo,
>> Can you take the series for ARM and ARM64?
>
> Wait: I thought you were going to add compat support for arm64? I haven't
> acked that patch yet, because it's lacking those changes.
The compat mode is supported by libdw and _should_ work in principle.
I am following it up with Mark Wielaard on elfutils-devel.
Cf. [1] for the discussion and [2] for the compat mode support in libdw.

[1] https://lists.fedorahosted.org/pipermail/elfutils-devel/2014-March/003905.html
[2] https://lists.fedorahosted.org/pipermail/elfutils-devel/2014-March/003910.html

So in summary the kernel changes should be fine (it works ok with
libunwind), the problem lies somewhere in the libdw registers setup
and usage for compat mode.

>
> The 32-bit ARM patches look fine though.
Thx!

>
> Will

Jean
