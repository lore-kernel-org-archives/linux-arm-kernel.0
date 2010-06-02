From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Wed, 2 Jun 2010 11:46:19 +0400
Subject: [PATCH 1/2] at91sam9g20ek: add fixed-value regulator for wm8731
In-Reply-To: <1275059443-10100-1-git-send-email-dbaryshkov@gmail.com>
References: <1275059443-10100-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <AANLkTimgLRs_MX036cEsoIOYWoGfG9--W86-O6BRWACE@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Any comments on these two patches? Can I submit them to patchsystem?

Without these patches the kernel with CONFIG_REGULATOR enabled is broken
on sam9g20ek boards (sound won't work).



On Fri, May 28, 2010 at 7:10 PM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:
> If CONFIG_REGULATOR is enabled, wm8731 fails on AT91SAM9G20EK board,
> since codec driver requires several voltage supplies and none are
> provided currently. As requires voltages are hardwired to 3V3, use fixed
> voltage regulator for this chip.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
> ?arch/arm/mach-at91/board-sam9g20ek.c | ? 45 ++++++++++++++++++++++++++++++++++
> ?1 files changed, 45 insertions(+), 0 deletions(-)

-- 
With best wishes
Dmitry
