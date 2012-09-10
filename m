From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 10 Sep 2012 17:28:14 +0200
Subject: [PATCH V2 1/2] hwmon: Add devicetree bindings to gpio-fan
In-Reply-To: <1347285112-13542-2-git-send-email-jm@lentin.co.uk>
References: <1347035675-23907-1-git-send-email-jm@lentin.co.uk>
 <1347285112-13542-1-git-send-email-jm@lentin.co.uk>
 <1347285112-13542-2-git-send-email-jm@lentin.co.uk>
Message-ID: <20120910152814.GA6050@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2012 at 02:51:51PM +0100, Jamie Lentin wrote:
> Allow a gpio-fan to be defined in devicetree, see binding documentation
> for details.
> 
> Changes since V1:-
> * Don't hide return codes [Guenter Roeck]
> * Remove typecast noise [Guenter Roeck]
> * Use of_find_property instead of counting u32s [Guenter Roeck]
> * Don't count GPIOs twice [Andrew Lunn]
> * Use of_prop_next_u32 to get records in a more obvious fashion
> * Use CONFIG_OF_GPIO instead of CONFIG_OF
> * Apply __devinitdata to of_gpio_fan_match [Andrew Lunn]
> 
> Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
> ---
>  .../devicetree/bindings/gpio/gpio-fan.txt          |   25 +++++
>  drivers/hwmon/gpio-fan.c                           |  116 ++++++++++++++++++++
>  2 files changed, 141 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-fan.txt

Hi Jamie

Thanks for addressing all the issues raised. However...

Anything before the --- ends up in the changelog entry. Anything
afterwards does not.

The changes you made to address review comments is not something for
the changelog, so Changes since V1:- should be after the --- .

There is more detail in Documentation/SubmittingPatches

      Andrew
