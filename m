From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 2 Oct 2015 19:00:58 +0100
Subject: [PATCH] arm64: dts: add all hi6220 uart nodes
In-Reply-To: <CANMBJr7yY1PJChnFSRknqfOLORuWZSEONV+e=M=9heX3i-ADKA@mail.gmail.com>
References: <1443558552-5734-1-git-send-email-tyler.baker@linaro.org>
 <1459065.BtzC7pyUYF@wuerfel> <20150930173145.GG15635@sirena.org.uk>
 <CANMBJr7yY1PJChnFSRknqfOLORuWZSEONV+e=M=9heX3i-ADKA@mail.gmail.com>
Message-ID: <20151002180058.GA4220@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tyler,

On Wed, 30 Sep 2015, Tyler Baker wrote:

> On 30 September 2015 at 10:31, Mark Brown <broonie@kernel.org> wrote:
> > On Wed, Sep 30, 2015 at 10:24:56AM +0200, Arnd Bergmann wrote:
> >> On Tuesday 29 September 2015 13:29:12 Tyler Baker wrote:
> >
> >> >         aliases {
> >> >                 serial0 = &uart0;
> >> > +               serial1 = &uart1;
> >> > +               serial2 = &uart2;
> >> > +               serial3 = &uart3;
> >> > +               serial4 = &uart4;
> >> >         };
> >
> >> In the changelog you mention "both uarts", but here you have five of them.
> >> Are they all accessible on the connector? If not, only provide aliases
> >> for the ones that are, using numbering that makes most sense for given
> >> how one would use the board.
> 
> Thanks for the comment Arnd. Mark's comment below is correct, there
> are only two UARTs accessible on the LS connection in addition to the
> one on the board (solder pad).
> 
> Is the following definition any clearer?
> 
> serial0 = &uart0; // Onboard UART0
> serial1 = &uart2; // LS expansion UART0
> serial2 = &uart3; // LS expansion UART1
> 
> If so, I'll respin this patch.
> 
> > Unless I'm missing something there's only two UARTs brought out on the
> > low speed expansion connector (in addition to the one on the solder pads
> > which is currently supported).  We should also adjust the console
> > default to match whatever one of the low speed expansion connector UARTs
> > is being used by the bootloader.
> 
> Your not missing anything, I should not have added the additional
> aliases, it is confusing, will remove. The UART boards by default come
> configured to use UART1 on the LS connector.
> 
> + Peter as he has been submitting u-boot patches recently for the HiKey.

Thanks :)

> 
> Obviously, both UEFI and u-boot can be configured to use either UART,
> and at the moment u-boot defaults to using the on board UART. Whereas
> UEFI is using UART1 on the LS connector. I'm fine with switching the
> console default to use the UART1 on the LS connector as long as there
> is agreement to do so.

Eek... "serial2 = uart3 //UART1"

I sent the following patch
http://lists.denx.de/pipermail/u-boot/2015-September/227465.html

which has been accepted which switches from using UART0 (onboard) to
UART3 (LS connector). This matched up with the change made in ATF i.e. both ATF
and u-boot were then both outputting on the same UART.

So u-boot has already been migrated over.

regards,

Peter.
