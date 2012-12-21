From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Fri, 21 Dec 2012 09:31:57 +0200
Subject: [PATCH 0/9] drivers: mailbox: framework creation
In-Reply-To: <CAOesGMh2uZC_9FzAxDVZqwe06OgqOrKjPgQi6wOJCt-SAmoHwg@mail.gmail.com>
References: <1355836212-17956-1-git-send-email-loic.pallardy-ext@stericsson.com>
 <CACRpkdaqO7AAeYeR8SZt4Tbv1grrMq85TNYMc-FSbUSrnZBm=Q@mail.gmail.com>
 <20121220182835.GB21056@atomide.com>
 <CAOesGMh2uZC_9FzAxDVZqwe06OgqOrKjPgQi6wOJCt-SAmoHwg@mail.gmail.com>
Message-ID: <CAK=Wgba=jLiig+TBcAcp7STz=Y6RM8noR_0S2HZjNQXLZV8JBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 20, 2012 at 9:19 PM, Olof Johansson <olof@lixom.net> wrote:
> While we can make the branch stable, would it make sense to make
> remoteproc for omap depend on !multiplatform during the transition, to
> reduce dependencies a little? Either way works, but it'd be nice to
> keep them independent if we can.

I'm not sure multiplatform is the culprit; OMAP's remoteproc driver
heavily depends on this mailbox code, and obviously breaks with this
patch-set if only for the the naming changes. We'll need this patch
set to update omap's remoteproc as well so at least we don't break
bisectibility, though running a sanity test before merging would be
even nicer (Loic I can help if you don't have a panda board).

BTW - grep shows that tidspbridge is using the mailbox code too, but
it's in staging and I'm not sure it gets much love. Nevertheless, as
long as it's there we should at least update it with the new API as
well.

Thanks,
Ohad.
