From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Mon, 23 Apr 2012 14:05:54 +0530
Subject: SPI subsystem delays
In-Reply-To: <CADjezmaB7yo6W1dW11JKtH7JNSsgXQvOQy5BMqtAUfe6sy2igA@mail.gmail.com>
References: <CADjezmaB7yo6W1dW11JKtH7JNSsgXQvOQy5BMqtAUfe6sy2igA@mail.gmail.com>
Message-ID: <CAJe_ZheQZFA_wuCPa+reHU3HOGku-iiQh-GjJOy6Xr=c+ExGiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 April 2012 02:37, Matt Wood <mattwood2000@gmail.com> wrote:
>
> has some specific delay requirements - specifically
> the delay between bytes in a single transfer
>
Sounds like your chip specific quirk. Apparently throughput would
be the last of your concerns :D
Perhaps you have to do single byte transfers with appropriate
non-zero 'delay_usecs' and skilfully toggle 'cs_change' for
each transfer.

> delay between chip select assertion and the first clock edge
>
IMO that could already be done from within your controller driver.

> and the delay between consecutive transfers.
>
Why not spi_transfer.delay_usecs ?

-jassi
