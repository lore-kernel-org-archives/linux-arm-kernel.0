From: shubhrajyoti.datta@gmail.com (Shubhrajyoti Datta)
Date: Wed, 5 Aug 2015 16:16:44 +0530
Subject: [PATCH-v5 2/5] i2c: pxa: enable/disable i2c module across msg xfer
In-Reply-To: <1437482466-16126-3-git-send-email-vaibhav.hiremath@linaro.org>
References: <1437482466-16126-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1437482466-16126-3-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <CAKfKVtGzDjgHzy70aa0d2W=ROMcxVzerg-qpuB9e4PaGKPpMTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi ,
On Tue, Jul 21, 2015 at 6:11 PM, Vaibhav Hiremath
<vaibhav.hiremath@linaro.org> wrote:
> From: Yi Zhang <yizhang@marvell.com>
>
> Enable i2c module/unit before transmission and disable when it
> finishes.
>
> why?
> It's because the i2c bus may be disturbed if the slave device,
> typically a touch, powers on.

Why should that be an issue?
Is it an errata.

In which mode it is an issue slave / master or both?

>
> As we do not want to break slave mode support, this patch introduces
> DT property to control disable of the I2C module after xfer in master
> mode of operation.
>
> i2c-disable-after-xfer : If set, driver will disable I2C module after
> msg xfer
>
> Signed-off-by: Yi Zhang <yizhang@marvell.com>
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
> ---
