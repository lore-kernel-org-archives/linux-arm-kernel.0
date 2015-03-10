From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 10 Mar 2015 16:04:45 +0530
Subject: [PATCH 0/3] clockevents: Manage device's state separately for core
In-Reply-To: <cover.1425037853.git.viresh.kumar@linaro.org>
References: <cover.1425037853.git.viresh.kumar@linaro.org>
Message-ID: <CAKohpok+bfVVm-6fW5+tJCOKQA+dY=8zHykdyJEcUNbgGQyrcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 February 2015 at 17:21, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Hi Thomas/Ingo,
>
> This is in response to the suggestions Ingo gave [1] on the shortcomings of
> clockevents core's state machine.
>
> This first separates out the RESUME functionality from other states as its a
> special case. Then it defines a new enum to map possible states of a clockevent
> device.
>
> Ideally it should only be available for the core, but as bL switcher is using it
> today, it is exposed in clockchips.h. That dependency will go away after
> applying the Thomas's work (Sent out be Peter) and then we can move this enum to
> somewhere in kernel/time/.
>
> The last patch moves the legacy check to the legacy code.
>
> Please see if this meets your expectation or if you have some suggestions on it.
>
> Rebased of tip/master as there were some dependencies:
> 575daeea39a3 Merge branch 'tools/kvm'
>
> This along with migration of few clockevents drivers is pushed here:
> git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git clkevt/manage-state
>
> --
> Viresh
>
> [1] https://lkml.org/lkml/2015/2/20/107
>
> Viresh Kumar (3):
>   clockevents: Handle tick device's resume separately
>   clockevents: Manage device's state separately for the core
>   clockevents: Don't validate dev->mode against CLOCK_EVT_MODE_UNUSED
>     for new interface

Ingo,

Gentle reminder ping...
