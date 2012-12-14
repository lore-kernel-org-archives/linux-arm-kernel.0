From: iwamatsu@nigauri.org (Nobuhiro Iwamatsu)
Date: Sat, 15 Dec 2012 06:24:00 +0900
Subject: [PATCH 1/2] thermal: Add support for thermal sensor for Kirkwood
 SoC
In-Reply-To: <20121208010708.260209f5@skate>
References: <1354922151-3250-1-git-send-email-iwamatsu@nigauri.org>
 <20121208010708.260209f5@skate>
Message-ID: <CABMQnVLuf+Mwainon6DPN1Wuz+LKmDi4wpM7RO6qLSKQOqtKpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Dec 8, 2012 at 9:07 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Hello,
>
> On Sat,  8 Dec 2012 08:15:50 +0900, Nobuhiro Iwamatsu wrote:
>
>> +config KIRKWOOD_THERMAL
>> +     tristate "Temperature sensor on Marvel Kirkwood"
>
> Marvell

Thanks, I will fix.
>
>> +     /* Valid check */
>> +     if (!(reg >> THERMAL_VALID_OFFSET) & THERMAL_VALID_MASK) {
>> +             dev_info(&thermal->device, "Reading temperature is not valid\n");
>
> "Temperature read is not valid" maybe? An native english speaker could
> say.

I will fix.

>
>> +     thermal_dev
>> +             = devm_kzalloc(&pdev->dev, sizeof(*thermal_dev), GFP_KERNEL);
>
> I think the usual coding style is to have the = on the first line.
>
>> +static int kirkwood_thermal_exit(struct platform_device *pdev)
>> +{
>> +     struct thermal_zone_device *kirkwood_thermal
>> +                     = platform_get_drvdata(pdev);
>
> Ditto.
>

I will fix.

>> +static const struct of_device_id kirkwood_thermal_id_table[] = {
>> +     { .compatible = "marvel,thermal-kirkwood" },
>
> marvel -> marvell

Thanks, I will fix.

>
> Also, I think it should be marvell,kirkwood-thermal, since most other
> DT compatible strings that we have for Marvell SoCs are
> marvell,<soc>-<function>.
>
> Also, the Device Tree binding documentation is missing (even though it
> is admittedly going to be a very short documentation).
>

OK, I forgot this.
I will write documentation.

> Thanks!
>
> Thomas
> --
> Thomas Petazzoni, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com

Best regards,
  Nobuhiro

-- 
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6
