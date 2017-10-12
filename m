From: joel@jms.id.au (Joel Stanley)
Date: Thu, 12 Oct 2017 11:37:30 +0800
Subject: [PATCH 11/11] ARM: dts: Add PCLK to the Aspeed watchdogs
In-Reply-To: <CACRpkdbJhTmSZDudJCb_8nOfk6802Z8Op2+gjY9vdDT9Cg+6eQ@mail.gmail.com>
References: <20170812184318.10144-1-linus.walleij@linaro.org>
 <20170812184318.10144-12-linus.walleij@linaro.org>
 <CACRpkdbJhTmSZDudJCb_8nOfk6802Z8Op2+gjY9vdDT9Cg+6eQ@mail.gmail.com>
Message-ID: <CACPK8XeQDdisecoHo7+_7LQNxYWh7yDj99O=NxWSoHyuk7LRxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 11, 2017 at 4:09 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sat, Aug 12, 2017 at 8:43 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>
>> This adds the PCLK clock to the Aspeed watchdog blocks.
>> I am not directly familiar with the Aspeed clocking, but
>> since the IP is derived from Faraday FTWDT010 it probably
>> has the ability to run the watchdog on the PCLK if
>> desired so to obtain the frequency from it, it needs to
>> be present in the device tree, and for completeness the
>> PCLK should also be referenced and enabled anyways.
>>
>> Take this opportunity to add the "faraday,ftwdt010"
>> compatible as fallback to the watchdog IP blocks.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> Joel could you merge this through the Aspeed tree? I think
> the compatible string is completely uncontroversial
> (binding ACKed) to add and all should just work fine so we
> can slap in "EXTCLK" later as well.

How do the clock-names work? I have been writing the aspeed clk driver
and updating the bindings without clock names, and instead using a
identifier in phandle to reference which clock the device wants.

eg:

 clocks = <&syscon 10>;

(I'm travelling over the next few weeks so my replies might be delayed)

Cheers,

Joel
