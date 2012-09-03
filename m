From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 3 Sep 2012 21:51:21 +0200
Subject: [PATCH 2/6 v2] ARM: integrator: check PL010 device name rather
 than base address
In-Reply-To: <CACRpkdYMjJFHscO1BztOFBRMf+YZo+jO5pCrEiGeeeU_Oh_rfw@mail.gmail.com>
References: <1346471760-23993-1-git-send-email-linus.walleij@linaro.org>
 <1346471760-23993-2-git-send-email-linus.walleij@linaro.org>
 <201209011832.47805.arnd@arndb.de>
 <CACRpkdYMjJFHscO1BztOFBRMf+YZo+jO5pCrEiGeeeU_Oh_rfw@mail.gmail.com>
Message-ID: <CACRpkdYUFSSMfcPqDLnaLeiYPF4Jc23BKSbjf0Fc=TnDmjE37Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 3, 2012 at 9:40 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sat, Sep 1, 2012 at 8:32 PM, Arnd Bergmann <arnd@arndb.de> wrote:

>> On Saturday 01 September 2012, Linus Walleij wrote:
>>> -       if (dev == &uart0_device) {
>>> +       if (!strcmp(dev_name(&dev->dev), "uart0")) {
>>>                 rts_mask = 1 << 4;
>>>                 dtr_mask = 1 << 5;
>>>         } else {
>>
>> Maybe it's possible to compare the base pointer against INTEGRATOR_UART0_BASE instead?
>
> Nope, that is an ioremapped() base, I have no clue what it may be.

But hey I have the struct amba_device there, so the mem resource is there
indeed :-) I'll fix!

Yours,
Linus Walleij
