From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 22 Mar 2016 21:52:41 +0100
Subject: [linux-sunxi] Re: [PATCH] musb: sunxi-glue: Fix sunxi-musb driver
 not auto-loading
In-Reply-To: <56F1A748.6070808@suse.de>
References: <1458598418-16959-1-git-send-email-hdegoede@redhat.com>
 <56F1A748.6070808@suse.de>
Message-ID: <56F1B099.1000005@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 22-03-16 21:12, Andreas F?rber wrote:
> Hi Hans,
>
> Am 21.03.2016 um 23:13 schrieb Hans de Goede:
>> Add a missing MODULE_DEVICE_TABLE() line which was causing the
>> sunxi-musb glue to not auto-load when build as a module.
>
> "built"

Thanks.

> Should this get a Fixes: header for backporting to stable?

Actually while looking for the commit id, it looks like someone
else has already beat me to it, and this is already fixes
in Linus' tree, so self NACK for this one.

Regards,

Hans


>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/usb/musb/sunxi.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
>> index 4b472b8..9af9431 100644
>> --- a/drivers/usb/musb/sunxi.c
>> +++ b/drivers/usb/musb/sunxi.c
>> @@ -756,6 +756,7 @@ static const struct of_device_id sunxi_musb_match[] = {
>>   	{ .compatible = "allwinner,sun8i-a33-musb", },
>>   	{}
>>   };
>> +MODULE_DEVICE_TABLE(of, sunxi_musb_match);
>>
>>   static struct platform_driver sunxi_musb_driver = {
>>   	.probe = sunxi_musb_probe,
>
> Has anyone looked into my earlier report about the module filename not
> having musb-? I did not see any response and haven't rechecked v4.5.0.
>
> Regards,
> Andreas
>
