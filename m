From: robh@kernel.org (Rob Herring)
Date: Fri, 2 Sep 2016 09:09:35 -0500
Subject: [PATCH v2] input: touchscreen: Add support for Elan eKTF2127
 touchscreen controller
In-Reply-To: <20160828160005.20415-1-hdegoede@redhat.com>
References: <20160828160005.20415-1-hdegoede@redhat.com>
Message-ID: <20160902140935.GA19453@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 28, 2016 at 06:00:05PM +0200, Hans de Goede wrote:
> From: Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>
> 
> This adds a driver for the Elan eKTF2127 touchscreen controller,
> which speaks an i2c protocol which is distinctly different from
> the already supported eKTH controllers.
> 
> Signed-off-by: Michel Verlaan <michel.verl@gmail.com>
> Signed-off-by: Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Improve devicetree bindings document
> -Use touchscreen_parse_properties and touchscreen_report_pos instead of DIY
> -Remove a bunch of unused defines (copy and paste leftover from chipone driver)
> -Some other minor cleanups and review comments addressed
> -Add defines for some command / address hex-values
> -Check packet header in interrupt handler
> ---
>  .../bindings/input/touchscreen/ektf2127.txt        |  27 ++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/input/touchscreen/Kconfig                  |  12 +
>  drivers/input/touchscreen/Makefile                 |   1 +
>  drivers/input/touchscreen/ektf2127.c               | 333 +++++++++++++++++++++
>  4 files changed, 373 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ektf2127.txt
>  create mode 100644 drivers/input/touchscreen/ektf2127.c
