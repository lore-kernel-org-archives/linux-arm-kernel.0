From: tfiga@chromium.org (Tomasz Figa)
Date: Thu, 11 Dec 2014 20:04:25 +0900
Subject: [RFC PATCH 1/2] pm: Add PM domain notifications
In-Reply-To: <548973B7.3050107@samsung.com>
References: <1418286387-9663-1-git-send-email-tfiga@chromium.org>
 <1418286387-9663-2-git-send-email-tfiga@chromium.org>
 <548973B7.3050107@samsung.com>
Message-ID: <CAAFQd5DrzYRCF3tW7cg=rZ3wB1G2kQtWbCx+Pby9obNTewsFdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

On Thu, Dec 11, 2014 at 7:36 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
>
> Hi Tomasz,
>
> On 11/12/14 09:26, Tomasz Figa wrote:
> > From: Sylwester Nawrocki <s.nawrocki@samsung.com>
> >
> > This patch adds notifiers to the runtime PM/genpd subsystem. It is now
> > possible to register a notifier, which will be called before and after
> > the generic power domain subsystem calls the power domain's power_on
> > and power_off callbacks.
> >
> > Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> > [tfiga at chromium.org: rebased]
> > Signed-off-by: Tomasz Figa <tfiga@chromium.org>
>
> Not sure if you've noticed it, I posted an updated version of this patch
> recently [1]. The notifiers list is moved to struct generic_pm_domain
> there and it also allows to register a notifier for selected power domain
> by name.
[snip]
> [1] http://www.spinics.net/lists/linux-samsung-soc/msg38549.html

Ah, haven't noticed, sorry. The API using devices looks the same, so I
guess we can simply have patch 2/2 of this series applied on top of
your patch.

By the way, look-up by name (presumably hardcoded somewhere?) sounds a
bit strange to me. What was the reason for it to be added?

Best regards,
Tomasz
