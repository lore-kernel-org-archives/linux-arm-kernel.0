From: tony@atomide.com (Tony Lindgren)
Date: Wed, 24 Jun 2015 21:38:39 -0700
Subject: Use of pinctrl-single for external device over I2C
In-Reply-To: <558AE478.2080802@linaro.org>
References: <55893B2C.1070800@linaro.org> <558A9CC7.6070409@linaro.org>
 <20150624133349.GI4156@atomide.com> <558AE478.2080802@linaro.org>
Message-ID: <20150625043838.GK4156@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Vaibhav Hiremath <vaibhav.hiremath@linaro.org> [150624 10:12]:
> 
> I do not like this, as this is not HW feature, so DT may not be right
> approach.
> 
> So I will dig more from either runtime or Compile time option to use
> regmap_ Vs raw read/writes.

Can't you just check if the pinctrl node has compatible = "syscon"
property?

A compile time option won't work for sure. I don't know what you
would check at runtime as you do not know what the bus is behind
syscon.

Regards,

Tony
