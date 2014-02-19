From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Wed, 19 Feb 2014 19:04:31 +0200
Subject: [PATCH v4 1/2] memory: ti-aemif: introduce AEMIF driver
In-Reply-To: <20140219143403.GA31063@kroah.com>
References: <1391629574-18955-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1391629574-18955-2-git-send-email-ivan.khoronzhuk@ti.com>
 <20140218203049.GA18647@kroah.com> <53048822.2080307@ti.com>
 <20140219143403.GA31063@kroah.com>
Message-ID: <5304E41F.4080205@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 02/19/2014 04:34 PM, Greg KH wrote:
> On Wed, Feb 19, 2014 at 12:32:02PM +0200, Ivan Khoronzhuk wrote:
>>>> +	aemif->clk = devm_clk_get(dev, NULL);
>>>> +	if (IS_ERR(aemif->clk)) {
>>>> +		dev_err(dev, "cannot get clock 'aemif'\n");
>>>> +		return PTR_ERR(aemif->clk);
>>> No freeing memory?
>> There is no need to free memory explicitly.
>> devm_kzalloc is used instead of kzalloc.
> Yes, but where does the device on the error path get removed?

Why these functions are needed in that case...

As I see, memory allocated with these functions
are automatically freed on driver detach.

Additionally I've checked if resources are released after
AEMIF driver probe error.
And they're released completely in case of probe error.

:-\

-- 
Regards,
Ivan Khoronzhuk
