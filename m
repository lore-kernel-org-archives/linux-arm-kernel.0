From: will.deacon@arm.com (Will Deacon)
Date: Wed, 26 Jul 2017 13:02:33 +0100
Subject: [PATCH] arm64: Convert to using %pOF instead of full_name
In-Reply-To: <CAL_JsqJFD4y3MXFApApj59brOyagysGjmrPFBGx96gf-ZjCdSA@mail.gmail.com>
References: <20170718214339.7774-2-robh@kernel.org>
 <20170725120422.GD27768@arm.com>
 <CAL_JsqJFD4y3MXFApApj59brOyagysGjmrPFBGx96gf-ZjCdSA@mail.gmail.com>
Message-ID: <20170726120233.GC2115@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Tue, Jul 25, 2017 at 07:27:29PM -0500, Rob Herring wrote:
> On Tue, Jul 25, 2017 at 7:04 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Tue, Jul 18, 2017 at 04:42:42PM -0500, Rob Herring wrote:
> >> Now that we have a custom printf format specifier, convert users of
> >> full_name to use %pOF instead. This is preparation to remove storing
> >> of the full path string for each node.
> >>
> >> Signed-off-by: Rob Herring <robh@kernel.org>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: Will Deacon <will.deacon@arm.com>
> >> Cc: linux-arm-kernel at lists.infradead.org
> >> ---
> >>  arch/arm64/kernel/cpu_ops.c  |  4 ++--
> >>  arch/arm64/kernel/smp.c      | 12 ++++++------
> >>  arch/arm64/kernel/topology.c | 22 +++++++++++-----------
> >>  3 files changed, 19 insertions(+), 19 deletions(-)
> >
> > I've queued this and the perf patch too, but it would be good if somebody
> > could update sparse to recognise this format specifier. Currently it
> > just complains about it.
> 
> I'm happy to fix it, but I ran sparse and don't see any errors. Got a pointer?

I went back and checked again and it's not sparse that's warning, it's
actually smatch (sorry for getting that mixed up):

  arch/arm64/kernel/cpu_ops.c:85 cpu_read_enable_method() error: unrecognized %p extension 'O', treated as normal %p [smatch]

Will
