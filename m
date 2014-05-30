From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 30 May 2014 20:25:16 +0100
Subject: [PATCH] i2c: Make I2C ID tables non-mandatory for DT'ed and/or
 ACPI'ed devices
In-Reply-To: <20140530174800.GA4917@katana>
References: <1401452797-29521-1-git-send-email-lee.jones@linaro.org>
 <1401452797-29521-2-git-send-email-lee.jones@linaro.org>
 <20140530123656.GC2742@katana> <20140530133405.GB29731@lee--X1>
 <20140530174800.GA4917@katana>
Message-ID: <20140530192516.GA4319@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Would you mind telling me what I have changed that affects drivers
> > registering via Sysfs?
> 
> Check Documentation/i2c/instantiating-devices, method 4. If a driver
> does not have i2c_device_id, then this method won't work because the
> newly created device has no of_node or ACPI_node and nothing will match.
> Looking at the bigger picture, I'd really like to keep this feature.
> People use it.

Right, I read the function which provides the functionality, but my
point is; I don't think my patch changes the semantics in a way which
would adversely affect this option.  If you think that it does, can you
specify how please?

Does the sysfs method create a i2c_device_id table?  If not, how does
it probe successfully pre-patch?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
