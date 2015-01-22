From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 22 Jan 2015 09:08:04 +0100
Subject: [PATCH RFC 2/3] power: mxs_power: add driver for mxs power
 subsystem
In-Reply-To: <20150121230148.GJ13715@earth.universe>
References: <1416514477-19190-1-git-send-email-stefan.wahren@i2se.com>
 <1416514477-19190-3-git-send-email-stefan.wahren@i2se.com>
 <20150121230148.GJ13715@earth.universe>
Message-ID: <54C0AFE4.3020701@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

[add Marek]

Am 22.01.2015 um 00:01 schrieb Sebastian Reichel:
> Hi Stefan,
>
> Sorry for the big delay.

a late answer is better than no answer :)

>
> On Thu, Nov 20, 2014 at 08:14:36PM +0000, Stefan Wahren wrote:
>> This patch adds a minimal driver for the Freescale i.MX23, i.MX28
>> power subsystem. It's required to trigger the probing of the underlying
>> drivers like on-chip regulators. Additionally the drivers supports
>> the configuration of the DC-DC clock frequency to avoid possible
>> interferences.
> I would expect PLL to be board specific and part of DT. Why is it
> specified as parameter?

I think the switching frequency of the DC-DC belongs to the
configuration and don't describe how the hardware is connected. But i
don't have a problem to change it into a DT property.

Does a common property name exists for the switching frequency or would
it be vendor specific?

> Apart from that the driver/patch looks fine to me.

In the meantime i made some bugfixes on these patches. Now i think it
would be better to integrate the on-chip regulator driver into the patch
series. That would clarify the function of the power driver.

> -- Sebastian

Best regards
Stefan
