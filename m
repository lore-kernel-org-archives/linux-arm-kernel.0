From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Mon, 14 Apr 2014 14:28:30 -0400
Subject: [PATCH v8 02/12] ARM/ARM64: KVM: Add common header for PSCI
 related defines
In-Reply-To: <1396515949-1459-3-git-send-email-anup.patel@linaro.org>
References: <1396515949-1459-1-git-send-email-anup.patel@linaro.org>
 <1396515949-1459-3-git-send-email-anup.patel@linaro.org>
Message-ID: <CAJ5Y-eYNzdO5X0e8GNT5Srd4q7JdE-aGpjrEBSxnT3tcq4g1CQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anup,

On 3 April 2014 05:05, Anup Patel <anup.patel@linaro.org> wrote:

> +/* PSCI version decoding (independent of PSCI version) */
> +#define PSCI_VERSION_MAJOR_MASK                        0xffff0000
> +#define PSCI_VERSION_MINOR_MASK                        0x0000ffff
> +#define PSCI_VERSION_MAJOR_SHIFT               16
> +#define PSCI_VERSION_MAJOR(ver)                        \
> +               (((ver) & PSCI_VER_MAJOR_MASK) >> PSCI_VER_MAJOR_SHIFT)
> +#define PSCI_VERSION_MINOR(ver)                        ((ver) & PSCI_VER_MINOR_MASK)

I just noticed this as I was preparing to rebase my patches on top of
yours. Looks like you modified my original version of these macros,
but forgot to change them completely. You still have the old "_VER_"
in there which are now undefined.

Can you please resend with this fix? If these are already picked up
for upstreaming, then I can send a follow up fix along with my v0.2
patchset which is (hopefully) the first user of these macros.

Thanks,
Ashwin
