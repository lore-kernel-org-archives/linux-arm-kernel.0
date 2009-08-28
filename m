From: bgat@billgatliff.com (Bill Gatliff)
Date: Thu, 27 Aug 2009 20:32:57 -0500
Subject: [PATCH] watchdog: Add support for the Avionic Design Xanthos
	watchdog timer.
In-Reply-To: <20090827204448.GL29382@infomag.iguana.be>
References: <20090821073105.GC29382@infomag.iguana.be>
	<1250860202-28187-1-git-send-email-thierry.reding@avionic-design.de>
	<20090822081806.GD29382@infomag.iguana.be>
	<20090824090407.GA24894@avionic-design.de>
	<20090827202314.GJ29382@infomag.iguana.be>
	<4A96ED32.7000108@billgatliff.com>
	<20090827204448.GL29382@infomag.iguana.be>
Message-ID: <4A9733C9.9090900@billgatliff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wim Van Sebroeck wrote:
> Hi Bill,
>
>   
>>> This is the only thing I'm still struggling with: the goal of a watchdog device driver is to make sure that the system reboots when the system isn't stable anymore. So why should you then trigger the interrupt?
>>>   
>>>       
>> ... because a hard reboot might not be the way he wants to resolve the  
>> situation.
>>     
>
> If your system is unstable then sending a keepalive to the watchdog during this interrupt is not going to change anything neither... Or am I missing something?
>   

All I'm saying is that it isn't always a given that a watchdog timeout 
should universally issue a hardware reset.  I've worked with systems 
where doing so would be a Really Bad Idea, and what we wanted instead 
was the ability to know when the watchdog timer had expired so that we 
could wrest control of the system away from the application.

Put another way, it isn't always the case that the _system_ has become 
unstable.  It's more likely that the _application_ has, and there are 
other ways to fix that than by issuing a hardware reset.

In the bigger picture, getting all the benefits out of a watchdog timer 
while at the same time avoiding their limitations can be a tricky 
business.  They're misused far more often than used properly, 
unfortunately.  I sense that you and I both recognize that.


b.g.

-- 
Bill Gatliff
bgat at billgatliff.com
