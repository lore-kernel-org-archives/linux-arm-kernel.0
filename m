From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 31 May 2014 15:48:06 +0200
Subject: [PATCH] i2c: Make I2C ID tables non-mandatory for DT'ed and/or
 ACPI'ed devices
In-Reply-To: <20140530192516.GA4319@lee--X1>
References: <1401452797-29521-1-git-send-email-lee.jones@linaro.org>
 <1401452797-29521-2-git-send-email-lee.jones@linaro.org>
 <20140530123656.GC2742@katana> <20140530133405.GB29731@lee--X1>
 <20140530174800.GA4917@katana> <20140530192516.GA4319@lee--X1>
Message-ID: <20140531134805.GA3287@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Right, I read the function which provides the functionality, but my
> point is; I don't think my patch changes the semantics in a way which
> would adversely affect this option.  If you think that it does, can you
> specify how please?

Currently, if a driver would be DT only and does not provide a seperate
i2c_device_id table, then the driver is unusable with method 4. I don't
like to have some drivers being capable of it and some not.

> Does the sysfs method create a i2c_device_id table?  If not, how does
> it probe successfully pre-patch?

The sysfs method creates a device. Its name is matched against
i2c_device_ids only since it does not have a node pointer for DT to be
matched against.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140531/ed161c08/attachment.sig>
