From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Tue, 02 Jun 2015 23:10:32 +0530
Subject: [PATCH 05/12] i2c: pxa: Add bus reset functionality
In-Reply-To: <20150602173341.GA1494@katana>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1432818224-17070-6-git-send-email-vaibhav.hiremath@linaro.org>
 <20150602173341.GA1494@katana>
Message-ID: <556DEA90.3010001@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 02 June 2015 11:03 PM, Wolfram Sang wrote:
>
>> Since there is some problematic i2c slave devices on some
>> platforms such as dkb (sometimes), it will drop down sda
>> and make i2c bus hang, at that time, it need to config
>> scl/sda into gpio to simulate "stop" sequence to recover
>> i2c bus, so add this interface.
>
> Please note that the i2c core has a bus recovery infrastructure.
> Search i2c.h for struct i2c_bus_recovery_info.
>


Yeah,
I assume you are referring to "i2c_generic_gpio_recovery", right?

Rob had suggested this, and will be using it in my next version.

Thanks,
Vaibhav
