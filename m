From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 19 Feb 2010 15:38:10 +0800
Subject: [PATCH 1/5] pxa/zeus: Allow usage of 8250-compatible UART in
	uncompress
In-Reply-To: <20100219071335.6b893aa7@taxman.wild-wind.fr.eu.org>
References: <20100218202612.6d6385e6@taxman.wild-wind.fr.eu.org>
	<f17812d71002182217n439da3c0n8b8dcee4e8318008@mail.gmail.com>
	<20100219071335.6b893aa7@taxman.wild-wind.fr.eu.org>
Message-ID: <f17812d71002182338t1a03d69r58ebb5dcf78eb414@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 19, 2010 at 3:13 PM, Marc Zyngier <maz@misterjones.org> wrote:
> On Fri, 19 Feb 2010 14:17:52 +0800
> Eric Miao <eric.y.miao@gmail.com> wrote:
>
>> On Fri, Feb 19, 2010 at 4:26 AM, Marc Zyngier <maz@misterjones.org> wrote:
>> > Zeus console port is wired to a 8250-compatible device
>> > (pxa UARTs are reserved to other uses). This patch
>> > allows such a configuration in the uncompress sequence.
>> >
>> > It has been regression-tested on a Viper using FFUART.
>> >
>> > Signed-off-by: Marc Zyngier <maz@misterjones.org>
>>
>> Hi Marc,
>>
>> I would like to modify the patch a little bit as follows (and into two),
>> please let me know if you are OK (better to go with your Ack):
>>
>> ? ? [ARM] pxa: refactor uncompress.h for non-PXA uarts
>>
>> ? ? The original patch came from Marc Zyngier where support of 8250-compatible
>> ? ? UART is required to show the uncompress information. Modified a little bit
>> ? ? here, including changes below:
>>
>> ? ? 1. #include <mach/regs-uart.h> is actually not necessary
>> ? ? 2. introduced uart_{read,write}() for different base and shift
>> ? ? 3. introduced uart_is_enabled() and assumed enabled always for
>> ? ? ? ?non-PXA uarts
>>
>> ? ? Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
>
> Hi Eric,
>
> Looks very good to me. Please find my
>
> Acked-by: Marc Zyngier <maz@misterjones.org>
>

Thanks. Will push the merged result (together with the rest of
your patches) after a while.
