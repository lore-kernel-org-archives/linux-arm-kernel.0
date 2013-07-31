From: timur@tabi.org (Timur Tabi)
Date: Wed, 31 Jul 2013 18:44:58 -0500
Subject: [PATCH 2/2] Convert PowerPC macro spin_event_timeout() to
 architecture independent macro
In-Reply-To: <20130731071630.GI8868@codeaurora.org>
References: <1375187900-17582-1-git-send-email-B44344@freescale.com>
 <1375187900-17582-3-git-send-email-B44344@freescale.com>
 <20130731071630.GI8868@codeaurora.org>
Message-ID: <CAOZdJXVvNBR-qf7LXNOHZVstH_Rebxwn-wAkSaBS53Wn55mYCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31, 2013 at 2:16 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>
> What do you do here if jiffies aren't incrementing (i.e
> interrupts are disabled). The time_before() check won't work
> there and it would be nice if we were able to use this in such
> situations. I think powerpc gets around this by reading the
> hardware timer directly?

I believe that jiffies is always a global variable.  It should behave
the same on PowerPC as on other architectures.

The answer to your question is that you should not use
spin_event_timeout() in interrupt context, because it yields.

(FYI, I'm the author of spin_event_timeout(), so please CC: me on all
changes to it)
