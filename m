From: swarren@wwwdotorg.org (Stephen Warren)
Date: Sun, 29 Apr 2012 13:25:05 -0600
Subject: Tegra board file deprecation schedule
In-Reply-To: <1335648381.13148.4.camel@antimon>
References: <4F9B0E7C.1060408@wwwdotorg.org> <1335648381.13148.4.camel@antimon>
Message-ID: <4F9D9591.60407@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/28/2012 03:26 PM, Lucas Stach wrote:
> Am Freitag, den 27.04.2012, 15:24 -0600 schrieb Stephen Warren:
>> Eventually, Tegra support will become device tree only in the mainline
>> kernel; arch/arm/mach-tegra/board* will be deleted.
>>
>> I propose the following policy towards this goal: I'd like to maintain
>> the board files until the relevant device tree file has the same level
>> of functionality. Once that is achieved, and a Linus kernel is release
>> with full support for the board via device tree, the board files can be
>> deleted from the next kernel release.
>>
>> Does anyone have any issues with this?
> 
> Do we have any way to describe the clocks in the device tree?

Not at present, although supporting that will probably be part of
Tegra's support of the common clock API and DT bindings.

> I'm
> planning to add support for the Toradex Colibri T20 processor module,
> which uses a 13MHz external OSC, so the generic clock init in the
> current dt code definitely won't work for this board.

I'm not actually sure that's true. I believe we measure the OSC
frequency during boot, and all the clock driver PLL tables have (or
should have) entries for the various supported crystal frequencies. I
wouldn't be too surprised if it all just worked, or could easily be
fixed to.

(I wouldn't consider this to be related to board file deprecation, since
there are currently no board files to be deprecated that rely on such a
feature anyway)
