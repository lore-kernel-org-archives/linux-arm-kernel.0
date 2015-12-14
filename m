From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 Dec 2015 13:02:27 +0100
Subject: [PATCH] i2c: allow building emev2 without slave mode again
In-Reply-To: <20151213090959.GB1570@katana>
References: <201512102224.cVm7Hcp0%fengguang.wu@intel.com>
 <2157023.1Ftpc9ZciN@wuerfel> <20151213090959.GB1570@katana>
Message-ID: <15285750.UWXWiNJ6YU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 13 December 2015 10:09:59 Wolfram Sang wrote:
> 
> What about not ifdeffing the inline function and keep the build error
> whenever someone uses it without I2C_SLAVE being selected?

The inline function is only added there for the case that I2C_SLAVE is
disabled, so that would be pointless.

However, what we could do is move the extern declaration outside of
the #ifdef to make it always visible. The if(IS_ENABLED(CONFIG_I2C_SLAVE))
check should then ensure that it never actually gets called, and we
get a link error if some driver gets it wrong.

	Arnd
