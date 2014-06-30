From: carlo@caione.org (Carlo Caione)
Date: Mon, 30 Jun 2014 19:43:22 +0200
Subject: [PATCH v7 3/6] input: misc: Add driver for AXP20x Power Enable Key
In-Reply-To: <20140630094712.GX7262@leverpostej>
References: <1404066237-20234-1-git-send-email-carlo@caione.org>
 <1404066237-20234-4-git-send-email-carlo@caione.org>
 <20140630094712.GX7262@leverpostej>
Message-ID: <CAOQ7t2ZSJgyyHxEgSxOfL=R8eAW47rYgeXfHY-FE0Ne5v=h6Ew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 11:47 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>> +static struct platform_driver axp20x_pek_driver = {
>> +       .probe          = axp20x_pek_probe,
>> +       .remove         = axp20x_pek_remove,
>> +       .driver         = {
>> +               .name           = "axp20x-pek",
>> +               .owner          = THIS_MODULE,
>> +       },
>> +};
>> +module_platform_driver(axp20x_pek_driver);
>
> So this requires platform data rather than a DTB? Or have I missed
> something?

It is not loaded by DTB but by the MFD core driver (axp20x). So I
assume this is still a platform device.

Regards,

-- 
Carlo Caione
