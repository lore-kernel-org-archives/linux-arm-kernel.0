From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 Aug 2012 16:09:46 -0700
Subject: [PATCH 04/22] ASoC: Ux500: Move MSP pinctrl setup into the MSP
 driver
In-Reply-To: <20120820115914.GP8450@gmail.com>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-5-git-send-email-lee.jones@linaro.org>
 <CACRpkda_xOyu9BFGRK4xTsXOO9RCJu7BbU-kPGpttVkR6mDMZg@mail.gmail.com>
 <20120820115914.GP8450@gmail.com>
Message-ID: <CACRpkdZse9Nq1acoAujV8ojhRKxykNX0ymcr51QAoanUbDW14g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 20, 2012 at 4:59 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, Aug 14, 2012 at 10:51:02AM +0200, Linus Walleij wrote:

>> But wait. These are just local statics. Surelty you can put these into
>> struct ux500_msp instead? Here it looks like these will be used for
>> all ports, so MSP2 will enable the pins requested by MSP1 etc
>> completely broken. So put it into the struct ux500_msp state
>> container from ux500_msp_i2s.h where it belongs.
>>
>> Refer to drivers/tty/serial/amba-pl011.c when in trouble. This
>> one is a good pinctrl example.
>
> How do you see the MSP1 and MSP3 usage protection working if I hide it
> all away in MSP specific structs?

Usage protection? Sorry not following. Please elaborate...

Yours,
Linus Walleij
