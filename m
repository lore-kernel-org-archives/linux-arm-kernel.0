From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 22 Oct 2014 10:29:51 +0200
Subject: [PATCH v5 1/3] power-domain: add power domain drivers for
 Rockchip platform
In-Reply-To: <CAMuHMdXwp3oBMFRQQVK1XusytxB_sNxJtJzMhAwdXecGxRJ=Ug@mail.gmail.com>
References: <1413882808-4669-1-git-send-email-jinkun.hong@rock-chips.com>
 <1413882808-4669-2-git-send-email-jinkun.hong@rock-chips.com>
 <20141021195854.GE8609@dtor-ws> <544725C4.4040703@rock-chips.com>
 <CAPDyKFp+aNJd_FEY6=-ubK0zvVDWh+x5ZsVG+AVpuBzpSqynOQ@mail.gmail.com>
 <CAMuHMdXwp3oBMFRQQVK1XusytxB_sNxJtJzMhAwdXecGxRJ=Ug@mail.gmail.com>
Message-ID: <CAPDyKFrfigDH143NnSCtfeNAuH+SK86Lm60Lo8kTT5Sp3cTksg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 October 2014 10:07, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, Oct 22, 2014 at 9:58 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> Now, I just realized that while Geert added attach|detach_dev()
>> callbacks for the generic PM domain, those are both "void" callbacks.
>> It means the deferred probe error handling is broken for these
>> callbacks. We should convert the attach_dev() callback into an int, I
>> will cook a patch immediately.
>
> That was changed in v3:
>   - Move calling of the callbacks to a point where dev->pm_domain is
>     valid, so the domain parameter is no longer needed,

That's good.

>   - Make callbacks return void.
>

But not this. :-) Sorry, for being too quick in reviewing that time.

Kind regards
Uffe
