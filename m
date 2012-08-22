From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 22 Aug 2012 13:49:22 +0200
Subject: [PATCH 0/7] Ux500 and MASK_ON_SUSPEND
In-Reply-To: <1345624986-5557-1-git-send-email-linus.walleij@stericsson.com>
References: <1345624986-5557-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CACRpkdYyrFZYuNSj+y7f1uyF53+TYqdSfEcpv28H677uS1fd6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 22, 2012 at 10:43 AM, Linus Walleij
<linus.walleij@stericsson.com> wrote:

> We have discovered transient IRQs when going to suspend on the
> Ux500 platform. This patch series hits all sources by marking
> the applicable IRQchips with MASK_ON_SUSPEND.
>
> I don't know if this is a common problem or seen in other
> platforms so comments are welcome.
>
> Else I request that the patches be merged into respective
> subtree, I will take care of the ux500, gpio and pinctrl
> patches myself, while Sam gets to merge all the MFD stuff.

Bah it turns out transient IRQs are only occurring on the pinctrl
and maybe GIC. Let's just flag these two, forget the rest of the
patches.

Yours,
Linus Walleij
