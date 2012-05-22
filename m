From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 22 May 2012 11:12:32 -0600
Subject: [PATCH RFC v2 2/2] pinctrl: add pinctrl gpio binding support
In-Reply-To: <20120522033501.GB27055@shlinux2.ap.freescale.net>
References: <1337346755-8761-1-git-send-email-b29396@freescale.com>
 <1337346755-8761-2-git-send-email-b29396@freescale.com>
 <4FB6AB9A.4080006@wwwdotorg.org>
 <20120522033501.GB27055@shlinux2.ap.freescale.net>
Message-ID: <4FBBC900.2070003@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/21/2012 09:35 PM, Dong Aisheng wrote:
> On Sat, May 19, 2012 at 04:05:46AM +0800, Stephen Warren wrote:
> ...
>>> +			np_gpio = of_find_node_by_phandle(phandle);
>>> +			if (!np_gpio) {
>>> +				dev_err(pctldev->dev,
>>> +					"failed to find gpio node(%s)\n",
>>> +					np_gpio->name);
>>
>> Perhaps devm_kfree(ranges) here so that if this is called multiple times
>> due to deferred probe, the allocations from the failed attempts don't
>> accumulate. Same for other error paths.
>
> I checked a bit more, it seems the resource will be removed first if there's
> a deffer probe error.

Oh yes of course - that makes sense.
