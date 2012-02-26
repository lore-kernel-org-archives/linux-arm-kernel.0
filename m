From: davem@davemloft.net (David Miller)
Date: Sat, 25 Feb 2012 21:28:05 -0500 (EST)
Subject: [PATCH v2] ARM: LPC32xx: Ethernet driver
In-Reply-To: <20120226015217.GA3257@tarshish>
References: <1330201304-24037-1-git-send-email-stigge@antcom.de>
 <20120226015217.GA3257@tarshish>
Message-ID: <20120225.212805.1394065389987976077.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Baruch Siach <baruch@tkos.co.il>
Date: Sun, 26 Feb 2012 03:52:18 +0200

> Hi Roland,
> 
> On Sat, Feb 25, 2012 at 09:21:44PM +0100, Roland Stigge wrote:
>> This patch adds an ethernet driver for the LPC32xx ARM SoC.
>> 
>> Signed-off-by: Roland Stigge <stigge@antcom.de>
> 
> [snip]
> 
>> +static int __init ethaddr(char *s)
>> +{
>> +	int i;
>> +	unsigned int r[6];
>> +
>> +	sscanf(s, "%x:%x:%x:%x:%x:%x",
>> +			&r[0], &r[1], &r[2], &r[3], &r[4], &r[5]);
>> +	for (i = 0; i < 6; i++)
>> +		mac_address[i] = (u8)r[i];
>> +
>> +	return 1;
>> +}
>> +__setup("ethaddr=", ethaddr);
> 
> Please use a module_param() instead of a top level kernel parameter.

Actually, remove this entirely, we don't add module parameters
to force the ethernet address.  That should be done in userland
in some fashion.

We've had many discussions about this recently, and this is the
consistent policy we want to enforce in all drivers from now on.
