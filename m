From: will.deacon@arm.com (Will Deacon)
Date: Thu, 6 Mar 2014 11:33:15 +0000
Subject: [PATCH 1/3] perf tests: Introduce perf_regs_load function on ARM
In-Reply-To: <CAFrcx1=3+zZPErXC7dehwpKHnmwE=cWh1mR0kzN0PONpFZKaUw@mail.gmail.com>
References: <1393840403-26639-1-git-send-email-jean.pihet@linaro.org>
 <1393840403-26639-2-git-send-email-jean.pihet@linaro.org>
 <20140304110042.GD8766@mudshark.cambridge.arm.com>
 <CAFrcx1=3+zZPErXC7dehwpKHnmwE=cWh1mR0kzN0PONpFZKaUw@mail.gmail.com>
Message-ID: <20140306113314.GD5202@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 05, 2014 at 02:17:00AM +0000, Jean Pihet wrote:
> On 4 March 2014 12:00, Will Deacon <will.deacon@arm.com> wrote:
> > On Mon, Mar 03, 2014 at 09:53:21AM +0000, Jean Pihet wrote:
> >> +     str lr, [r0, #PC]       @ Save caller PC
> >
> > This isn't necessarily the `caller PC' (depending on how you define it).
> > It's the return address, which is probably (but not always) the instruction
> > following the branch to this function.
> Agreed. However the perf test code expects a registers buffer filled
> in with the caller's values.
> I can change the comment here, is that needed?

It depends what the perf test code really expects. At the moment, you're not
providing it with anything consistent which doesn't sound correct.

What does it use the caller PC for?

Will
