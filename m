From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 19 Aug 2013 11:56:52 +0200
Subject: [RFC] ARM: ux500: remove u8500_secondary_startup from INIT
 section.
In-Reply-To: <1375360855-25219-1-git-send-email-srinivas.kandagatla@st.com>
References: <1375360855-25219-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <CACRpkdYo+XpQPo-dVR4Xm33kUdj1NuT0wzU4t3N06LzhSjMO0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 1, 2013 at 2:40 PM, Srinivas KANDAGATLA
<srinivas.kandagatla@st.com> wrote:

> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
>
> This patch removes u8500_secondary_startup from _INIT section, there are
> two  reason for this removal.
> 1. discarding such a small code does not save much, given the RAM sizes.
> 2. Having this code discarded, creates corruption issue when we boot
> smp-kernel with nr_cpus=1 or with single cpu node in DT.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> ---
> Hi,
>
> I did encounter corruption issues on STi CA9 SOCs when a SMP kernel is booted with
> nr_cpus=1. This boiled down to freeing the __INIT section of the secondary
> startup code. It looks like two other SOCs(Spear and ux500) might have same
> issue.
>
> Do you think this patch is valid for ux500?

Yes, tentatively applied, I cannot test the patch right now since
ux500 has some boot regression and I'm hunting the cause.

Yours,
Linus Walleij
