From: carlo@caione.org (Carlo Caione)
Date: Fri, 11 Apr 2014 15:04:32 +0200
Subject: [PATCH v4 7/9] ARM: sun7i/sun4i: dt: Add AXP209 support to
 various boards
In-Reply-To: <20140411122901.GE28800@sirena.org.uk>
References: <1397209093-10077-8-git-send-email-carlo@caione.org>
 <20140411122901.GE28800@sirena.org.uk>
Message-ID: <CAOQ7t2Y2B7f+eZApDHKiKm9=bOXo6oUA2RLY7ENn7qPLQEboMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 11, 2014 at 2:29 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Apr 11, 2014 at 11:38:11AM +0200, Carlo Caione wrote:
>
>> In all the DTs the min and max microvolt allowed for each regulator are actually
>> the min and max voltage possible for the regulator itself. This is not safe but
>> we do not have the ranges allowed for each board and the original Allwinner
>> driver does exactly this way.
>
> Is there any code in their kernel which varies the supply voltages?  If
> there isn't then simply omitting the voltage ranges is the best option,
> leaving the supplies fixed.  If there is then the range it uses is a
> good starting point.  In general supplies will be fixed voltage on a
> given board unless there is a specific reason to vary them.

The supply voltage (ipsout) for the regulators is fixed and AFAIK
there is no code for changing it.
I'll omit the voltage ranges then.

>> +                             regulators {
>> +                                     compatible = "x-powers,axp20x-reg";
>
> This compatible isn't part of the driver.

Yes I know. The problem here is that in v4 I had to fill in the field
.of_compatible of the mfd_cell with "x-powers,axp20x-reg". This
because the regulator_dev_lookup() checks for dev->of_node when
looking for the supply so I needed the compatible string in the DT to
have the dev->of_node filled in by mfd_add_device().
What do you suggest? Modify the regulator driver?

Thank you,

-- 
Carlo Caione
