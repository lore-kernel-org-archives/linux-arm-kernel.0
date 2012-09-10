From: jm@lentin.co.uk (Jamie Lentin)
Date: Mon, 10 Sep 2012 17:04:26 +0100 (BST)
Subject: [PATCH V2 1/2] hwmon: Add devicetree bindings to gpio-fan
In-Reply-To: <20120910152814.GA6050@lunn.ch>
References: <1347035675-23907-1-git-send-email-jm@lentin.co.uk>
 <1347285112-13542-1-git-send-email-jm@lentin.co.uk>
 <1347285112-13542-2-git-send-email-jm@lentin.co.uk>
 <20120910152814.GA6050@lunn.ch>
Message-ID: <alpine.DEB.2.00.1209101656120.10589@marmot.wormnet.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Sep 2012, Andrew Lunn wrote:

> On Mon, Sep 10, 2012 at 02:51:51PM +0100, Jamie Lentin wrote:
>> Allow a gpio-fan to be defined in devicetree, see binding documentation
>> for details.
>>
>> Changes since V1:-
>> * Don't hide return codes [Guenter Roeck]
>> * Remove typecast noise [Guenter Roeck]
>> * Use of_find_property instead of counting u32s [Guenter Roeck]
>> * Don't count GPIOs twice [Andrew Lunn]
>> * Use of_prop_next_u32 to get records in a more obvious fashion
>> * Use CONFIG_OF_GPIO instead of CONFIG_OF
>> * Apply __devinitdata to of_gpio_fan_match [Andrew Lunn]
>>
>> Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
>> ---
>>  .../devicetree/bindings/gpio/gpio-fan.txt          |   25 +++++
>>  drivers/hwmon/gpio-fan.c                           |  116 ++++++++++++++++++++
>>  2 files changed, 141 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-fan.txt
>
> Hi Jamie
>
> Thanks for addressing all the issues raised. However...
>
> Anything before the --- ends up in the changelog entry. Anything
> afterwards does not.
>
> The changes you made to address review comments is not something for
> the changelog, so Changes since V1:- should be after the --- .

Okay, whilst I was submitting the initial DT support it was suggested by 
Grant Likely they should be above the '---'. I think I prefer this also, 
but I'll go with whatever is more likely to get patches accepted :)

Can resend with the content jiggled if you want, but will put them after 
the '---' in future.

>
> There is more detail in Documentation/SubmittingPatches
>
>      Andrew
>

-- 
Jamie Lentin
