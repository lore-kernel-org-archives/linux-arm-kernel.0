From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 8 May 2012 12:43:41 +0300
Subject: [PATCH v2 1/3] omap: mailbox: enable mailbox irq per instance
In-Reply-To: <CADVn9RHc4b+hLth5j-1Jr+dv2ePB8W1pGAgQiBSgFKuDycG8pA@mail.gmail.com>
References: <1334360392-1494-1-git-send-email-jgutierrez@ti.com>
 <1334360392-1494-2-git-send-email-jgutierrez@ti.com>
 <CAK=WgbY3OaDH9ziavrXG4oM1ztO3mTmL_eoLPOzCHHKQpHn20w@mail.gmail.com>
 <CADVn9RHc4b+hLth5j-1Jr+dv2ePB8W1pGAgQiBSgFKuDycG8pA@mail.gmail.com>
Message-ID: <CAK=WgbZBMtn57uHn33OAK_EQizCfiXe2nVHx-4g22vJ7t7DC5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Juan,

On Tue, May 8, 2012 at 1:09 AM, Gutierrez, Juan <jgutierrez@ti.com> wrote:
> Startup it is now only used to enable pm runtime of the whole mbox module.

Btw I really doubt we need to do that in a machine-specific handler,
or whether we really need this startup/shutdown abstraction at all.
But that's not related to your patch of course...

> I think, if request_irq is called from the generic layer, it is kind
> of logical to enable_irq next to it.

I somewhat agree, though I was wondering about the implications for
OMAP1, which didn't seem to enable_irq at startup at all. Not sure
there's much to do here (unless you have some OMAP1 hardware ? :).

Thanks,
Ohad.
