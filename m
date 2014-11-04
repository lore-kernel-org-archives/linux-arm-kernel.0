From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 4 Nov 2014 11:13:50 +0100
Subject: [PATCH] mfd: db8500-prcmu: Provide sane error path values
In-Reply-To: <20141103165035.GB12011@x1>
References: <1415031356-11664-1-git-send-email-lee.jones@linaro.org>
 <CAOMZO5C2sB1GNuNE-Bi5jqMO4DqBcDW2C1O+asYkbW=8fXA7TA@mail.gmail.com>
 <20141103165035.GB12011@x1>
Message-ID: <CACRpkdb-6-cjHhtLMNf_jevqqmew9u0OAL-rpFd5mfiwK6C6Ww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 3, 2014 at 5:50 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Mon, 03 Nov 2014, Fabio Estevam wrote:
>
>> On Mon, Nov 3, 2014 at 2:15 PM, Lee Jones <lee.jones@linaro.org> wrote:
>>
>> >         /* Clean up the mailbox interrupts after pre-kernel code. */
>> > @@ -3179,15 +3179,14 @@ static int db8500_prcmu_probe(struct platform_device *pdev)
>> >         irq = platform_get_irq(pdev, 0);
>> >         if (irq <= 0) {
>>
>> Shouldn't this be if (irq < 0) then?
>
> Perhaps Linus can answer that.
>
> Linus,
>
>   Is 0 a valid IRQ on the u8500 platform or not?

It is not. 0 is NO_IRQ and should be so for every system... just
the lazy and ancient ones lag behind.

Yours,
Linus Walleij
