From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Sep 2011 09:26:05 +0100
Subject: [PATCH] clk: provide prepare/unprepare functions
In-Reply-To: <4E7B72C2.3060402@codeaurora.org>
References: <20110922101024.GK17169@n2100.arm.linux.org.uk>
	<4E7B72C2.3060402@codeaurora.org>
Message-ID: <20110927082605.GR22455@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2011 at 10:39:14AM -0700, Saravana Kannan wrote:
>>   /**
>> + * clk_prepare - prepare a clock source
>> + * @clk: clock source
>> + *
>> + * This prepares the clock source for use.
>
> Do you want to add a "May NOT be called from atomic context"? Yeah, the  
> stub makes it obvious, but I think it would be consistent to add the  
> comment in. No strong opinion though.

The might_sleep() is sufficient to enforce that, but adding the comment
for when the helper goes away would be a good idea.

> Not sure if you care, but LGTM/Ack.

Thanks.
