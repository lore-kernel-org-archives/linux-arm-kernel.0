From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 18 Feb 2018 17:08:32 -0800
Subject: [PATCH v3 5/7] watchdog: mtk: allow setting timeout in devicetree
In-Reply-To: <20180219000835.ualdfczfsnjzqr6d@rob-hp-laptop>
References: <20180211200847.25000-1-marcus.folkesson@gmail.com>
 <20180211200847.25000-5-marcus.folkesson@gmail.com>
 <20180219000835.ualdfczfsnjzqr6d@rob-hp-laptop>
Message-ID: <46ff7605-5166-477b-85b1-7d2f53f7c57b@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/18/2018 04:08 PM, Rob Herring wrote:
> On Sun, Feb 11, 2018 at 09:08:45PM +0100, Marcus Folkesson wrote:
>> watchdog_init_timeout() will allways pick timeout_param since it
>> defaults to a valid timeout.
>>
>> By following best practice described in
>> Documentation/watchdog/watchdog-kernel-api.txt, it also
>> let us to set timout-sec property in devicetree.
> 
> Same problems in this one.
> 

Same answer. In the existing driver;

         mtk_wdt->wdt_dev.timeout = WDT_MAX_TIMEOUT;

Guenter

>>
>> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 4 ++++
>>   drivers/watchdog/mtk_wdt.c                             | 2 +-
>>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
