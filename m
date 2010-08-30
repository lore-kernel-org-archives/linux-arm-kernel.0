From: ryan@bluewatersys.com (Ryan Mallon)
Date: Mon, 30 Aug 2010 19:05:09 +1200
Subject: [PATCH 1/7] mmc: at91_mci: fix pointer errors
In-Reply-To: <4C7B5601.5060505@auerswald.de>
References: <9535dc8dfe4476a0314b9513fb9d37862faa731d.1267209149.git.nicolas.ferre@atmel.com>
	<20100827193303.GB23079@void.printf.net>
	<4C7AD3A0.40607@bluewatersys.com> <4C7B5601.5060505@auerswald.de>
Message-ID: <4C7B5825.6030302@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wolfgang M?es wrote:
> Hi,
> 
> Am 29.08.2010 23:39, schrieb Ryan Mallon:
>> I see this is already applied, but why all the type trickery here? Why
>> not just:
>>
>>     memcpy(dmabuf, sgbuffer, amount);
>>     dmabuf += amount / sizeof(dmabuf);
> 
> Because this is wrong?
> 
> Maybe you mean sizeof(*dmabuf)?

Sorry, yes.

> The exact style of the bug fix is not important, it's important that
> it's fixed.

I disagree, it's also important that it is fixed in a clear,
understandable way. I found the fix confusing, especially since there
are casts to both signed and unsigned char.

~Ryan
