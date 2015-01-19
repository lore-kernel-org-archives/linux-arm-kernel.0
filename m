From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 19 Jan 2015 11:35:47 +0100
Subject: [PATCH v4 4/5] ARM: mediatek: Add EINT support to MTK pinctrl
 driver.
In-Reply-To: <1421376639.31355.169.camel@mtksdaap41>
References: <1418772873-19747-1-git-send-email-hongzhou.yang@mediatek.com>
 <1418772873-19747-5-git-send-email-hongzhou.yang@mediatek.com>
 <1418807365.6443.17.camel@mtksdaap41>
 <1420535817.17567.10.camel@mtksdaap41>
 <CACRpkdb2KJbjzFgTmDvHSw7jNAExxVtU3y4_fgyn6J8hcW5OrQ@mail.gmail.com>
 <1421202745.27675.148.camel@mtksdaap41>
 <CACRpkdY7_A_rORDvDrGtV0aa6mJGj=Sr-k=KVGu_=0et-gNpiQ@mail.gmail.com>
 <1421376639.31355.169.camel@mtksdaap41>
Message-ID: <CACRpkda4dqY4uMmCz_uFB_n50A3OpSBr4p1g0sZ8Kty5Ou+gkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 16, 2015 at 3:50 AM, Yingjoe Chen <yingjoe.chen@mediatek.com> wrote:
> On Thu, 2015-01-15 at 18:30 +0100, Linus Walleij wrote:

>> But the EINT is not a hardware number is it?
>
> It is a hardware number. eg, to mask irq for the gpio 0 above, we have
> to set bit49 in EINT mask_set register. When this irq triggered, it is
> reported using EINT status register bit49.

OK I get it (finally) then you should indeed use the irqdomain for it...
It's just a bit confusing that it begins at offset 49...

Yours,
Linus Walleij
