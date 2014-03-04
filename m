From: robherring2@gmail.com (Rob Herring)
Date: Tue, 4 Mar 2014 17:31:03 -0600
Subject: [PATCH 5/5] arm64: add early_ioremap support
In-Reply-To: <1393963738-9210-6-git-send-email-msalter@redhat.com>
References: <1393963738-9210-1-git-send-email-msalter@redhat.com>
 <1393963738-9210-6-git-send-email-msalter@redhat.com>
Message-ID: <CAL_JsqLQ8gj4nkwh+67i58rQBARoh_CgZ+4D9uepdBQm-XBwJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 4, 2014 at 2:08 PM, Mark Salter <msalter@redhat.com> wrote:
> Add support for early IO or memory mappings which are needed
> before the normal ioremap() is usable. This also adds fixmap
> support for permanent fixed mappings such as that used by the
> earlyprintk device register region.

One minor comment:

> +enum fixed_addresses {
> +       FIX_EARLYCON,

Can you align this name with x86 and rename to FIX_EARLYCON_MEM_BASE.
Doing that will help enable the earlycon driver in 8250_early.c.

Rob
