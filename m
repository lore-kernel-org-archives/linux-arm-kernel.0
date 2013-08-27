From: archit@ti.com (Archit Taneja)
Date: Tue, 27 Aug 2013 14:00:24 +0530
Subject: [PATCH v5] gpio: pcf857x: Add OF support
In-Reply-To: <2063335.Uqxok8bYMn@flatron>
References: <1377590559-14279-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <2063335.Uqxok8bYMn@flatron>
Message-ID: <521C63A0.10902@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tuesday 27 August 2013 01:44 PM, Tomasz Figa wrote:
> Hi Laurent,
>
> On Tuesday 27 of August 2013 10:02:39 Laurent Pinchart wrote:
>> Add DT bindings for the pcf857x-compatible chips and parse the device
>> tree node in the driver.
>>
>> Signed-off-by: Laurent Pinchart
>> <laurent.pinchart+renesas@ideasonboard.com> ---
>>   .../devicetree/bindings/gpio/gpio-pcf857x.txt      | 71
>> ++++++++++++++++++++++ drivers/gpio/gpio-pcf857x.c
>>    | 44 +++++++++++--- 2 files changed, 107 insertions(+), 8
>> deletions(-)
>>   create mode 100644
>> Documentation/devicetree/bindings/gpio/gpio-pcf857x.txt
>>
>> Changes since v4:
>>
>> - Don't try to get ngpio from of_device_id data, we already get it from
>>    i2c_device_id
>
> Hmm, I'm not sure how this is supposed to work.
>
> How does the I2C core resolve OF compatible name to particular entry in
> id_table? I believe it simply passes NULL as the second argument of
> .probe() if the device is instantiated based on OF compatible string and
> not one in the legacy ID table.

It doesn't pass the second argument as NULL. If you look at 
i2c_device_probe() in drivers/i2c/i2c-core.c, the second argument to 
probe is passed as: i2c_match_id(driver->id_table, client)

This will extract the i2c_device_id pointer from the id_table.

Archit
