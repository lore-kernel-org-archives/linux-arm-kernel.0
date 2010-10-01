From: robherring2@gmail.com (Rob Herring)
Date: Thu, 30 Sep 2010 22:23:06 -0500
Subject: [PATCH 1/3] ARM: move timer-sp.c from versatile to common
In-Reply-To: <20101001023921.GB25320@game.jcrosoft.org>
References: <1285886952-30888-1-git-send-email-robherring2@gmail.com>
	<20101001023921.GB25320@game.jcrosoft.org>
Message-ID: <4CA5541A.9070108@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/30/2010 09:39 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 17:49 Thu 30 Sep     , Rob Herring wrote:
>> From: Rob Herring<rob.herring@smooth-stone.com>
>>
>> The timer-sp h/w used on versatile platforms can also be used for other
>> platforms, so move it to a common location.
>>
>> Rename timer names for clocksource and clockevent to generic name.
>> Which timer instance is which is platform dependent.
>>
> How about move it to drivers/clocksource ?
>
> Best Regards,
> J.
I'll defer to Russell. It's not exactly common practice to put timer 
code there. The ones that are there don't appear to be the primary 
system timers as they are initialized by initcalls which is not early 
enough.

Rob
