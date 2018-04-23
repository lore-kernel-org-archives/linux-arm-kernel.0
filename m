From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 23 Apr 2018 08:04:48 +0200
Subject: [PATCH 10/61] gpio: simplify getting .drvdata
In-Reply-To: <20180421162333.d4jtidmbxrx76k4x@ninjato>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-11-wsa+renesas@sang-engineering.com>
 <34f4679f-d306-073b-eae0-28c9e8965780@xilinx.com>
 <20180421162333.d4jtidmbxrx76k4x@ninjato>
Message-ID: <19e48035-917c-7bb0-eef3-a7d6db4c1db2@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On 21.4.2018 18:23, Wolfram Sang wrote:
> Hi Michal,
> 
> Thanks for the reviews!
> 
>> There are two more occurences in this gpio-zynq driver.
>> zynq_gpio_resume, zynq_gpio_suspend. It wasn't detected because these
>> two lines are not together. But the same change can be applied for them too.
> 
> Not really. The rule would have matched if there was just "something"
> inbetween. It did not match because the "something" involves the
> variable 'pdev', so we can't remove it. And just changing towards
> 'dev_get_drvdata' and keeping 'pdev' was not worth the hazzle in my
> book. Especially since I think the code should probably get refactored.
> Calling platform_get_irq() in suspend/resume paths in order to get the
> irq_data looks a little expensive to me, but I haven't tested it.
> 

ok. Thanks. I have overlooked that.

Thanks,
Michal
