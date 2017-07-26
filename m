From: robh@kernel.org (Rob Herring)
Date: Tue, 25 Jul 2017 19:27:29 -0500
Subject: [PATCH] arm64: Convert to using %pOF instead of full_name
In-Reply-To: <20170725120422.GD27768@arm.com>
References: <20170718214339.7774-2-robh@kernel.org>
 <20170725120422.GD27768@arm.com>
Message-ID: <CAL_JsqJFD4y3MXFApApj59brOyagysGjmrPFBGx96gf-ZjCdSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 25, 2017 at 7:04 AM, Will Deacon <will.deacon@arm.com> wrote:
> [adding Luc]
>
> Hi Rob,
>
> On Tue, Jul 18, 2017 at 04:42:42PM -0500, Rob Herring wrote:
>> Now that we have a custom printf format specifier, convert users of
>> full_name to use %pOF instead. This is preparation to remove storing
>> of the full path string for each node.
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: linux-arm-kernel at lists.infradead.org
>> ---
>>  arch/arm64/kernel/cpu_ops.c  |  4 ++--
>>  arch/arm64/kernel/smp.c      | 12 ++++++------
>>  arch/arm64/kernel/topology.c | 22 +++++++++++-----------
>>  3 files changed, 19 insertions(+), 19 deletions(-)
>
> I've queued this and the perf patch too, but it would be good if somebody
> could update sparse to recognise this format specifier. Currently it
> just complains about it.

I'm happy to fix it, but I ran sparse and don't see any errors. Got a pointer?

Rob
