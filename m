From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 30 May 2014 19:48:00 +0200
Subject: [PATCH] i2c: Make I2C ID tables non-mandatory for DT'ed and/or
 ACPI'ed devices
In-Reply-To: <20140530133405.GB29731@lee--X1>
References: <1401452797-29521-1-git-send-email-lee.jones@linaro.org>
 <1401452797-29521-2-git-send-email-lee.jones@linaro.org>
 <20140530123656.GC2742@katana> <20140530133405.GB29731@lee--X1>
Message-ID: <20140530174800.GA4917@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

sorry for the delay.

> Would you mind telling me what I have changed that affects drivers
> registering via Sysfs?

Check Documentation/i2c/instantiating-devices, method 4. If a driver
does not have i2c_device_id, then this method won't work because the
newly created device has no of_node or ACPI_node and nothing will match.
Looking at the bigger picture, I'd really like to keep this feature.
People use it.

Regards,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140530/5fb539ef/attachment.sig>
