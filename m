From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Tue, 25 Sep 2012 16:28:17 +0900
Subject: [PATCH 1/3] mmc: sdhci: rename platform_8bit_width to
 platform_bus_width
In-Reply-To: <20120925061504.GV1322@pengutronix.de>
References: <1348471345-30785-1-git-send-email-s.hauer@pengutronix.de>
 <1348471345-30785-2-git-send-email-s.hauer@pengutronix.de>
 <50611862.7010201@samsung.com> <20120925061504.GV1322@pengutronix.de>
Message-ID: <50615D11.8000503@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/25/2012 03:15 PM, Sascha Hauer wrote:
> On Tue, Sep 25, 2012 at 11:35:14AM +0900, Jaehoon Chung wrote:
>> On 09/24/2012 04:22 PM, Sascha Hauer wrote:
>>>  	/*
>>>  	 * If your platform has 8-bit width support but is not a v3 controller,
>>>  	 * or if it requires special setup code, you should implement that in
>>> -	 * platform_8bit_width().
>>> +	 * platform_bus_width().
>>>  	 */
>>> -	if (host->ops->platform_8bit_width)
>>> -		host->ops->platform_8bit_width(host, ios->bus_width);
>>> -	else {
>>> +	if (host->ops->platform_bus_width) {
>>> +		host->ops->platform_bus_width(host, ios->bus_width);
>>> +	} else {
>> Why add the brackets?
> 
> Took the chance to cleanup the codingstyle when changing these lines
> anyway.
Anyway, this patch is reasonable. Looks good to me.

Best Regards,
Jaehoon Chung
> 
> Sascha
> 
> 
