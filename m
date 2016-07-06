From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Wed, 06 Jul 2016 15:48:27 +0800
Subject: [linux-sunxi] [PATCH 2/4] power: add axp20x-battery driver
In-Reply-To: <577C8A6D.8000409@computerlinguist.org>
References: <20160701092926.32005-1-icenowy@aosc.xyz>
 <20160701092926.32005-2-icenowy@aosc.xyz> <577B44FD.6040404@mailbox.org>
 <4101467707611@web7h.yandex.ru> <577C8A6D.8000409@computerlinguist.org>
Message-ID: <1108451467791307@web8g.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



06.07.2016, 12:35, "Michael Haas" <haas@computerlinguist.org>:
> Hi There,
>
> On 05.07.2016 10:33, Icenowy Zheng wrote:
>> ?On 01.07.2016 11:29, Icenowy Zheng wrote:
>
>>>> ???+
>>>> ???+static enum power_supply_property axp22x_battery_properties[] = {
>>>> ???+ POWER_SUPPLY_PROP_CAPACITY,
>>>> ???+ POWER_SUPPLY_PROP_HEALTH,
>>>> ???+ POWER_SUPPLY_PROP_PRESENT,
>>>> ???+ POWER_SUPPLY_PROP_STATUS,
>>>> ???+ POWER_SUPPLY_PROP_CURRENT_NOW,
>>>> ???+ POWER_SUPPLY_PROP_VOLTAGE_NOW,
>>>> ???+};
>
> Here's what Bruno's driver supports:
>
> static enum power_supply_property axp20x_battery_power_properties[] = {
> ?????POWER_SUPPLY_PROP_PRESENT,
> ?????POWER_SUPPLY_PROP_ONLINE,
> ?????POWER_SUPPLY_PROP_STATUS,
> ?????POWER_SUPPLY_PROP_VOLTAGE_NOW,
> ?????POWER_SUPPLY_PROP_CURRENT_NOW,
> ?????POWER_SUPPLY_PROP_CURRENT_MAX,
> ?????POWER_SUPPLY_PROP_HEALTH,
> ?????POWER_SUPPLY_PROP_TECHNOLOGY,
> ?????POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
> ?????POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
> ?????/* POWER_SUPPLY_PROP_POWER_NOW, */
> ?????POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> ?????/* POWER_SUPPLY_PROP_CHARGE_NOW, */
> ?????POWER_SUPPLY_PROP_CAPACITY,
> ?????POWER_SUPPLY_PROP_TEMP,
> ?????POWER_SUPPLY_PROP_TEMP_ALERT_MIN,
> ?????POWER_SUPPLY_PROP_TEMP_ALERT_MAX,
> };
>
>>>> ???+
>>>> ???+static int axp20x_battery_probe(struct platform_device *pdev)
>>>> ???+{
>>>> ???+ struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
>>>> ???+ struct power_supply_config psy_cfg = {};
>>>> ???+ struct axp20x_battery *power;
>>>> ???+ static const char * const axp22x_irq_names[] = {
>>>> ???+ "BATT_PLUGIN", "BATT_REMOVAL", "BATT_ENT_ACT_MODE",
>>>> ???+ "BATT_EXIT_ACT_MODE", "CHARG", "CHARG_DONE", NULL };
>
> And here are the interrupts handled:
>
> static const char * const irq_names[] = { "BATT_HOT", "BATT_COLD",
> ?????????"BATT_PLUGIN", "BATT_REMOVAL", "BATT_ACTIVATE",
> ?????????"BATT_ACTIVATED", "BATT_CHARGING", "BATT_CHARGED",
> ?????????"BATT_CHG_CURR_LOW", "BATT_POWER_LOW_WARN",
> ?????????"BATT_POWER_LOW_CRIT" };
>
> There are a couple of issues with the version of Bruno's driver that I have:
>
> * power management is disabled (in the driver, not in the charger) -
> think suspend/resume
> * the temperature sensor data is not turned into a temperature value
> correctly
> * the IRQ handlers need to be cleaned up (remove logging)
> * device tree binding documentation is missing
>
> Other than that, it's basically working and I have been using it at
> least for some testing.
>
> The device tree bindings support:
> * OCV curve support
> * battery resistance
> * battery capacity
> * temp sensor settings
>
> You can find my copy of Bruno's driver here:
> https://github.com/mhaas/linux-sunxi/blob/axp209-charger/drivers/power/axp20x_fuel_gauge.c
>
> Thanks,
>
> Michael

Michael Haas:
I'm grateful for you providing your axp20x_fuel_gauge.c copy.

I will try to tidy it up and add support for axp22x.

Thanks,

Icenowy
