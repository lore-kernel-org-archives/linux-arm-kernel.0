From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 1 Jul 2014 15:51:27 +0300
Subject: [PATCHv5 06/15] hwspinlock/omap: enable module before reading
 SYSSTATUS register
In-Reply-To: <1398904476-26200-7-git-send-email-s-anna@ti.com>
References: <1398904476-26200-1-git-send-email-s-anna@ti.com>
 <1398904476-26200-7-git-send-email-s-anna@ti.com>
Message-ID: <CAK=WgbaKPgLLw-4wCSToE86QrREDB0sK95TLx2y17d71eBPFbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suman,

On Thu, May 1, 2014 at 3:34 AM, Suman Anna <s-anna@ti.com> wrote:
> The number of hwspinlocks are determined based on the value read
> from the IP block's SYSSTATUS register. However, the module may
> not be enabled and clocked, and the read may result in a bus error.
>
> This particular issue is seen rather easily on AM33XX, since the
> module wakeup is software controlled, and it is disabled out of
> reset. Make sure the module is enabled and clocked before reading
> the SYSSTATUS register.

This seems like a valid fix that is independent of this patch series.

Feel free to submit it separately if you want, so we can get it merged.

Thanks,
Ohad.
