From: dwmw2@infradead.org (David Woodhouse)
Date: Wed, 23 Sep 2015 19:41:54 +0100
Subject: [PATCH 2/2] Convert smsc911x to use ACPI as well as DT
In-Reply-To: <1439417187-21411-3-git-send-email-jeremy.linton@arm.com>
References: <1439417187-21411-1-git-send-email-jeremy.linton@arm.com>
 <1439417187-21411-3-git-send-email-jeremy.linton@arm.com>
Message-ID: <1443033714.74600.18.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-08-12 at 17:06 -0500, Jeremy Linton wrote:
> 
>  
> +static const struct acpi_device_id smsc911x_acpi_match[] = {
> +       { "ARMH9118", 0 },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(acpi, smsc911x_acpi_match);
> +
>  static struct platform_driver smsc911x_driver = {
>         .probe = smsc911x_drv_probe,
>         .remove = smsc911x_drv_remove,
> @@ -2661,6 +2656,7 @@ static struct platform_driver smsc911x_driver =
> {
>                 .name   = SMSC_CHIPNAME,
>                 .pm     = SMSC911X_PM_OPS,
>                 .of_match_table = of_match_ptr(smsc911x_dt_ids),
> +               .acpi_match_table = ACPI_PTR(smsc911x_acpi_match),
>         },
>  };

Hm, surely you shouldn't need this part? If the ACPI device has a HID
of PRP0001, and an appropriate "compatible" property, then it ought to
be loaded anyway. If that doesn't work, we should fix that.

-- 
dwmw2

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5691 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150923/20acbdc8/attachment.bin>
