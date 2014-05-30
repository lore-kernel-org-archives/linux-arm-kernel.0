From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 30 May 2014 14:36:57 +0200
Subject: [PATCH] i2c: Make I2C ID tables non-mandatory for DT'ed and/or
 ACPI'ed devices
In-Reply-To: <1401452797-29521-2-git-send-email-lee.jones@linaro.org>
References: <1401452797-29521-1-git-send-email-lee.jones@linaro.org>
 <1401452797-29521-2-git-send-email-lee.jones@linaro.org>
Message-ID: <20140530123656.GC2742@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 30, 2014 at 01:26:36PM +0100, Lee Jones wrote:
> Currently the I2C framework insists on devices supplying an I2C ID
> table.  Many of the devices which do so unnecessarily adding quite a
> few wasted lines to kernel code.  This patch allows drivers a means
> to 'not' supply the aforementioned table and match on either DT
> and/or ACPI match tables instead.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Sadly, it is not that easy...

> +	/*
> +	 * An I2C ID table is not madatory, if and only if, a suitable Device
> +	 * Tree and/or ACPI match table entry is supplied for the probing
> +	 * device.
> +	 */

That means we end up with drivers which cannot be used for run-time
instantiation via the 'new_device'-file in sysfs. I don't like that.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140530/9bf142e5/attachment.sig>
