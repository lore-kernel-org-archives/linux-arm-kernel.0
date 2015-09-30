From: tyler.baker@linaro.org (Tyler Baker)
Date: Wed, 30 Sep 2015 11:12:58 -0700
Subject: [PATCH] arm64: dts: add all hi6220 uart nodes
In-Reply-To: <20150930173145.GG15635@sirena.org.uk>
References: <1443558552-5734-1-git-send-email-tyler.baker@linaro.org>
 <1459065.BtzC7pyUYF@wuerfel> <20150930173145.GG15635@sirena.org.uk>
Message-ID: <CANMBJr7yY1PJChnFSRknqfOLORuWZSEONV+e=M=9heX3i-ADKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 September 2015 at 10:31, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Sep 30, 2015 at 10:24:56AM +0200, Arnd Bergmann wrote:
>> On Tuesday 29 September 2015 13:29:12 Tyler Baker wrote:
>
>> >         aliases {
>> >                 serial0 = &uart0;
>> > +               serial1 = &uart1;
>> > +               serial2 = &uart2;
>> > +               serial3 = &uart3;
>> > +               serial4 = &uart4;
>> >         };
>
>> In the changelog you mention "both uarts", but here you have five of them.
>> Are they all accessible on the connector? If not, only provide aliases
>> for the ones that are, using numbering that makes most sense for given
>> how one would use the board.

Thanks for the comment Arnd. Mark's comment below is correct, there
are only two UARTs accessible on the LS connection in addition to the
one on the board (solder pad).

Is the following definition any clearer?

serial0 = &uart0; // Onboard UART0
serial1 = &uart2; // LS expansion UART0
serial2 = &uart3; // LS expansion UART1

If so, I'll respin this patch.

> Unless I'm missing something there's only two UARTs brought out on the
> low speed expansion connector (in addition to the one on the solder pads
> which is currently supported).  We should also adjust the console
> default to match whatever one of the low speed expansion connector UARTs
> is being used by the bootloader.

Your not missing anything, I should not have added the additional
aliases, it is confusing, will remove. The UART boards by default come
configured to use UART1 on the LS connector.

+ Peter as he has been submitting u-boot patches recently for the HiKey.

Obviously, both UEFI and u-boot can be configured to use either UART,
and at the moment u-boot defaults to using the on board UART. Whereas
UEFI is using UART1 on the LS connector. I'm fine with switching the
console default to use the UART1 on the LS connector as long as there
is agreement to do so.

> While we're at it there was a recent talk which mentioned a fairly large
> amount of functionality that's apparently already "upstream" for this
> device but not included in the DT, assuming that means that driver
> support is there it would be good to add the corresponding DT.

Indeed, I think this comment is targeted to toward the d410c though as
there are drivers for eMMC, and microsd drivers upstream but no DT
bindings. I do not believe currently this is the case for HiKey.

Cheers,

Tyler
