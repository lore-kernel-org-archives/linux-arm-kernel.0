From: davem@davemloft.net (David Miller)
Date: Mon, 19 Jun 2017 10:49:26 -0400 (EDT)
Subject: [PATCH v4 03/11] net: mvmdio: use GENMASK for masks
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD0025C9A@AcuExch.aculab.com>
References: <20170614154911.14510-1-antoine.tenart@free-electrons.com>
 <20170614154911.14510-4-antoine.tenart@free-electrons.com>
 <063D6719AE5E284EB5DD2968C1650D6DD0025C9A@AcuExch.aculab.com>
Message-ID: <20170619.104926.732811694966999045.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Laight <David.Laight@ACULAB.COM>
Date: Mon, 19 Jun 2017 11:57:51 +0000

> From: Antoine Tenart
>> Sent: 14 June 2017 16:49
>> Cosmetic patch to use the GENMASK helper for masks.
> ...
>> -	ret = val & 0xFFFF;
>> +	ret = val & GENMASK(15, 0);
> 
> My 2c: It isn't at all clear to me that changes like this in anyway
> improve the code readability.
> In some sense the '15' should be a named constant - but that just makes
> it even less obvious what is going on.

I agree, a hexidecimal mask of 0xffff is 100 times more readable and
understandable to me than "SOME_MACRO(x, y)".
