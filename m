From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Mon, 21 Oct 2013 09:49:28 -0500
Subject: [PATCH] imx6q: fix emergency restart
In-Reply-To: <20131020232217.GS25034@n2100.arm.linux.org.uk>
References: <1380832337-4637-1-git-send-email-nathan_lynch@mentor.com>
 <20131020232217.GS25034@n2100.arm.linux.org.uk>
Message-ID: <52653EF8.8030902@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/20/2013 06:22 PM, Russell King - ARM Linux wrote:
> On Thu, Oct 03, 2013 at 03:32:17PM -0500, Nathan Lynch wrote:
>> @@ -192,8 +188,15 @@ static void __init imx6q_1588_init(void)
>>  
>>  static void __init imx6q_init_machine(void)
>>  {
>> +	struct device_node *np;
>> +
>>  	imx6q_enet_phy_init();
>>  
>> +	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-wdt");
>> +	if (np)
>> +		wdog_base = of_iomap(np, 0);
>> +	pr_info("%s: wdog_base = %p\n", __func__, wdog_base);
> 
> I don't know whether this has been applied yet, but please don't add
> to the kernel messages unnecessarily; there's already enough of them
> and unless it provides something which is useful, it doesn't deserve
> to be at "info" level.  If you want it to report it for debugging,
> then please use the debugging level.

Yeah, sorry, it was just debug cruft I didn't intend to include in the
final patch.  Sloppy :(
