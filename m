From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 23 Jul 2015 11:48:45 +0200
Subject: [PATCH v2] ARM: dts: i.MX35: Fix can support.
In-Reply-To: <55B0B3E8.20900@pengutronix.de>
References: <20150722180434.GA745@pengutronix.de>
 <1437640272-5054-1-git-send-email-denis@eukrea.com>
 <55B0ACBD.6030903@i2se.com> <55B0B3E8.20900@pengutronix.de>
Message-ID: <55B0B87D.5070800@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 23.07.2015 um 11:29 schrieb Marc Kleine-Budde:
> On 07/23/2015 10:58 AM, Stefan Wahren wrote:
>> Hi Denis,
>>
>> [ add Marc to CC ]
>>
>> Am 23.07.2015 um 10:31 schrieb Denis Carikli:
>>> Since commit 3d42a379b6fa5b46058e3302b1802b29f64865bb
>>> ("can: flexcan: add 2nd clock to support imx53 and newer")
>>> the can driver requires a dt nodes to have a second clock.
>>> Add them to imx35 to fix probing the flex can driver on the
>>> respective platforms.
>> could you describe the problem more in detail or do you have a log in
>> case the probing failed?
>>
>> According to Marc's commit this fix shouldn't be necessary.
> In the pre DT era and without a clock name, a single clock is
> sufficient. But with clock name or DT with clock-name you need both a
> "ipg" and a "per" clock. The imx35.dtsi was added with one clock only,
> so it was probably never working on mx35 with DT.

Okay the other plaforms like mx25 and mx28 already had 2 clocks defined.

But why doesn't say the binding doc nothing about those required clocks?

Stefan

>
> Marc
>
