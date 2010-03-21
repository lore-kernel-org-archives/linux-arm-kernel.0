From: vzapolskiy@gmail.com (Vladimir Zapolskiy)
Date: Sun, 21 Mar 2010 21:27:08 +0300
Subject: [PATCH 1/3] watchdog: Add support for the Freescale MXC watchdog
In-Reply-To: <20100321103637.GA26984@pengutronix.de> (Wolfram Sang's message
	of "Sun, 21 Mar 2010 11:36:37 +0100")
References: <1269011607-23077-1-git-send-email-vzapolskiy@gmail.com>
	<20100320120939.GA5515@pengutronix.de> <87aau2x2ew.fsf@vovsem.com>
	<20100321103637.GA26984@pengutronix.de>
Message-ID: <87d3yx4jk3.fsf@vovsem.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wolfram Sang <w.sang@pengutronix.de> writes:

Hi,

> Hi Vladimir,
>
> On Sat, Mar 20, 2010 at 09:40:07PM +0300, Vladimir Zapolskiy wrote:
>
>> The driver is extremely simple, so from my biased position only minor
>> benefits can be found in my version:
>> * introduced spinlock to protect concurrent write to registers
>> * SETTIMEOUT option is present and it works well on imx31
>> * correct zero byte write()
>> * clock enabled only when watchdog node is opened
>> * dynamic wdt structure, which potentially simplifies future support of
>>   several watchdogs found on imx51 and imx37 IIRC
>> * no critical message on close with unset NOWAYOUT on non-imx1 SoCs
>> 
>> Your pretty good version supports imx1, and I cann't test my version on
>> imx1, because I don't have such hardware on hand.
>> 
>> Obviously better to update your reviewed one, and I hope some comments or even
>> updates from my side could be accepted by you :)
>
> Thanks for agreeing on the procedure and pointing out the benefits of your
> driver. I will surely have a look at them and don't be surprised if you will
> find this or that incorporated ;) I haven't really started yet, so I might be
> missing something: What races do you want to protect against with the spinlock?
> The ping?
>

locking was added in analogy with other watchdog drivers. Just checked
imx1, imx3 and imx5 reference manuals, for all chips "any number of
instructions can be executed between two writes" to WSR. I understand
this that only ping/ping races can influence the watchdog, and that kind
of race does not look harmful.

So the locking could be omitted.

With best wishes,
Vladimir
