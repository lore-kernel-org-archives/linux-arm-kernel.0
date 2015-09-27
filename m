From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 27 Sep 2015 16:02:40 +0300
Subject: [PATCH 2/4] of: irq: Add support for the new definition of
 "msi-parent"
In-Reply-To: <alpine.DEB.2.11.1509271226340.4500@nanos>
References: <1442944336-11754-1-git-send-email-marc.zyngier@arm.com>
 <1442944336-11754-3-git-send-email-marc.zyngier@arm.com>
 <5602B994.9080409@cogentembedded.com>
 <alpine.DEB.2.11.1509271226340.4500@nanos>
Message-ID: <5607E8F0.6070106@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 9/27/2015 1:29 PM, Thomas Gleixner wrote:

>>> -	d = irq_find_matching_host(msi_np, DOMAIN_BUS_PLATFORM_MSI);
>>> -	if (!d)
>>> -		d = irq_find_host(msi_np);
>>> -	dev_set_msi_domain(dev, d);
>>> +		d = irq_find_matching_host(args.np, DOMAIN_BUS_PLATFORM_MSI);
>>> +		if (!d)
>>
>> 		if (!d) {
>>
>>> +			d = irq_find_host(args.np);
>>> +
>>> +		if (d) {
>>
>> 		} else {
>>
>>> +			dev_set_msi_domain(dev, d);
>>> +			return;
>>> +		}
>
> Errm, no. How is that equivalent?
>
> Marc:
>
>        d = foo();
>        if (!d)
>        	 d = bar();
>        if (d) {
>           bla(d);
> 	 return;
>        }
>
> Yours:
>
>        d = foo();
>        if (!d) {
>        	 d = bar();
>        } else {
>           bla(d);
> 	 return;
>        }
>
> Hmm?

    Ah, sorry, didn't notice the kind of assignment in the first branch. :-<

> Thanks,
> 	tglx

MBR, Sergei
