From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Wed, 31 Oct 2012 16:28:38 +0530
Subject: [PATCH RFC] i2c: omap: Fix the revision register read
In-Reply-To: <20121031101201.GB10094@arwen.pp.htv.fi>
References: <1351673959-5918-1-git-send-email-shubhrajyoti@ti.com>
 <20121031101201.GB10094@arwen.pp.htv.fi>
Message-ID: <5091045E.8040407@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 31 October 2012 03:42 PM, Felipe Balbi wrote:
>>  
>> > +	if (!_dev->regs)
>> > +		return 0;
> this is wrong, you need to make sure dev->regs is set early enough.


to set the dev->regs I use the value read from revision register.

to read the revision register I do a get_sync first. This in turn leads
to the call to resume handler.
At this point the regs is NULL and so the check.

After reading the register and checking the scheme bit.
the reg map is populated.

How can this issue be solved?
