From: jean.pihet@linaro.org (Jean Pihet)
Date: Wed, 25 Jun 2014 16:54:14 +0200
Subject: [PATCH] ARM: perf: allow tracing with kernel tracepoints events
In-Reply-To: <20140625090110.GD6153@arm.com>
References: <CAFrcx1n-cPXm=w+84gQiUjZoFKi7gYnvJ0BQ+8yXKS=k3nEt3g@mail.gmail.com>
 <1403025065-18001-1-git-send-email-jean.pihet@linaro.org>
 <20140618125355.GA2186@arm.com>
 <CAFrcx1mA7kXiG9wMQqn=zYPYqrpGxDYWfoMP97RvkkrMTvNoRw@mail.gmail.com>
 <20140625090110.GD6153@arm.com>
Message-ID: <CAFrcx1=gwRzU9heY8o9sphWUiga63NGdpN+cUh81Njr-X-OEGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 25 June 2014 11:01, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Jun 20, 2014 at 09:10:35AM +0100, Jean Pihet wrote:
>> Hi Will,
>
> Hi Jean,
>
>> On 18 June 2014 14:53, Will Deacon <will.deacon@arm.com> wrote:
>> > On Tue, Jun 17, 2014 at 06:11:05PM +0100, Jean Pihet wrote:
>> >> Tested with perf record and tracepoints filtering (-e <tracepoint>), with
>> >> unwinding using fp (--call-graph fp) and dwarf info (--call-graph dwarf).
>> >
>> > Whilst the old ACPS unwinding only needs PC, FP and SP, is this definitely
>> > true for exidx and DWARF-based unwinding? Given that libunwind ends up
>> > running a state machine for the latter, can we guarantee that we won't hit
>> > instructions that require access to other general purpose registers?
>> Yes. dwarf unwinding does not need anything extra. Once seeded all the
>> rest is extracted from the dwarf trace info.
>
> Ok, but what if the LR isn't saved on the stack, for example? What if the
> code you're trying to unwind is hand-written assembly annotated with CFI
> directives?
Then in that case the unwinding is not possible unless the
hand-crafted asm is compatible with the requested unwinding method
(fp, dwarf etc.). Do you expect problems there, if so can you give
more details?

>
> Will

Jean
