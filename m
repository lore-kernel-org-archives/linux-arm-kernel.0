From: robherring2@gmail.com (Rob Herring)
Date: Mon, 19 Jan 2015 12:08:21 -0600
Subject: [PATCH v4 01/21] serial: rewrite pxa2xx-uart to use 8250_core
In-Reply-To: <1397668411-27162-2-git-send-email-ynvich@gmail.com>
References: <1387309071-22382-1-git-send-email-ynvich@gmail.com>
 <1397668411-27162-1-git-send-email-ynvich@gmail.com>
 <1397668411-27162-2-git-send-email-ynvich@gmail.com>
Message-ID: <CAL_JsqJUWRhGA_8NU+O=fLFdMiVNz0LV6G0LU=ikgk=zah2q2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 12:13 PM, Sergei Ianovich <ynvich@gmail.com> wrote:
> pxa2xx-uart was a separate uart platform driver. It was declaring
> the same device names and numbers as 8250 driver. As a result,
> it was impossible to use 8250 driver on PXA SoCs.
>
> Upon closer examination pxa2xx-uart turned out to be a clone of
> 8250_core driver.
>
> Workaround for Erratum #19 according to Marvel(R) PXA270M Processor
> Specification Update (April 19, 2010) is dropped. 8250_core reads
> from FIFO immediately after checking DR bit in LSR.
>
> Signed-off-by: Sergei Ianovich <ynvich@gmail.com>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Reviewed-by: James Cameron <quozl@laptop.org>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  Resenging together with the rest of the series as the series
>  breaks without this one at [PATCH 12/21]

Whatever happened with merging this? I'm asking because either this or
fixes to PXA uart are needed to coexist with the 8250 driver and for
earlycon to work.

Rob
