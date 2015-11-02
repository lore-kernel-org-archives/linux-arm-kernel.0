From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 2 Nov 2015 12:00:02 +0100
Subject: [PATCH 05/13 v2] irqchip/gic: assign irqchip dynamically
In-Reply-To: <5637328F.7060601@arm.com>
References: <1445591083-22494-1-git-send-email-linus.walleij@linaro.org>
 <5637328F.7060601@arm.com>
Message-ID: <CACRpkdYhe41MFBE-ANXOnMHCQ7eXtkU-h8WbRzWzfsWoh1xj=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 2, 2015 at 10:53 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 23/10/15 10:04, Linus Walleij wrote:

>> Marc: can't test the EOIMODE1 thing, it's far above me, but it
>> "should work". Is it correct that there is one unique and coupled
>> EOIMODE1 instance per GIC instance like this?
>
> I'm afraid you misinterpreted the EOIMODE==1 thing. The GIC can either
> be EOIMODE==0 (which is what most people are using on 32bit when not
> booting at HYP), or EOIMODE==1 (most 64bit systems). For systems with
> multiple GICs, the secondary GICs are always EOIMODE==0.

So it's an either-or thing not both-and. OK that's the missing piece,
thanks Marc, I'll fix up the patch.

Yours,
Linus Walleij
