From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 14 Mar 2011 21:52:58 +0300
Subject: [PATCH] DM644x EVM: register MUSB device earlier
In-Reply-To: <20110314085248.GA2285@legolas.emea.dhcp.ti.com>
References: <201103132306.59986.sshtylyov@ru.mvista.com>
	<20110314085248.GA2285@legolas.emea.dhcp.ti.com>
Message-ID: <4D7E640A.9090908@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Felipe Balbi wrote:

>> The MUSB driver doesn't see its platform device on DM644x EVM board anymore
>> since commit 73b089b052a69020b953312a624a6e1eb5b81fab (usb: musb: split davinci
>> to its own platform_driver) because the new probe is called as subsys_initcall()
>> now, and the device is registered later than that by the board code.  Move the
>> registration to davinci_evm_init() -- it's safe to do so because the MUSB core
>> device still gets initialized as fs_initcall() -- which is late enough for the
>> I2C GPIO expander (which controls VBUS) to be initialized.

>> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> Kevin feel free to take this into your tree:

> Acked-by: Felipe Balbi <balbi@ti.com>

    Thanks.

>> ---
>> The patch is against the recent DaVinci tree.
>> It fixes post 2.6.38-rc1 regression, so should be applied immediately!

> I wonder how noone has noticed that from -rc1 until now.

    I don't think many people run the most current DaVinci kernel. Most people 
probably use the Arago project kernels or even older MV-based TI's stuff...

WBR, Sergei
