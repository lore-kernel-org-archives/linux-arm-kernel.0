From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 2 Jan 2012 23:03:41 +0530
Subject: [RFC][PATCH 4/4] lcd: platform-lcd: Add device tree support
In-Reply-To: <20120102073406.GG13015@ponder.secretlab.ca>
References: <1325483675-21908-1-git-send-email-thomas.abraham@linaro.org>
 <1325483675-21908-2-git-send-email-thomas.abraham@linaro.org>
 <1325483675-21908-3-git-send-email-thomas.abraham@linaro.org>
 <1325483675-21908-4-git-send-email-thomas.abraham@linaro.org>
 <1325483675-21908-5-git-send-email-thomas.abraham@linaro.org>
 <20120102073406.GG13015@ponder.secretlab.ca>
Message-ID: <CAJuYYwTk=+p=FQeM4eyhLt-qKzTdb2KuJ=OZmSPng1qK-jyzJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

On 2 January 2012 13:04, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Mon, Jan 02, 2012 at 11:24:35AM +0530, Thomas Abraham wrote:
>> Add device tree based initialization for Hydis hv070wsa lcd panel.
>>
>> Cc: Ben Dooks <ben-linux@fluff.org>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>> ?drivers/video/backlight/platform_lcd.c | ? 33 ++++++++++++++++++++++++++++++++
>> ?1 files changed, 33 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/video/backlight/platform_lcd.c b/drivers/video/backlight/platform_lcd.c

[...]

>> +#ifdef CONFIG_OF
>> + ? ? if (pdev->dev.of_node) {
>> + ? ? ? ? ? ? const struct of_device_id *match;
>> + ? ? ? ? ? ? match = of_match_node(platform_lcd_dt_match, pdev->dev.of_node);
>> + ? ? ? ? ? ? return (struct plat_lcd_driver_data *)match->data;
>
> .data is already void*; the cast should not be necessary.

Thanks. I will remove the cast.

Regards,
Thomas.

[...]
