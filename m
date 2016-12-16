From: david@lechnology.com (David Lechner)
Date: Fri, 16 Dec 2016 14:41:48 -0600
Subject: [PATCH v7 1/2] provide lock-less versions of clk_{enable|disable}
In-Reply-To: <35adff3d-c6a6-7b65-fb61-6da447dd6c3f@baylibre.com>
References: <1481302773-14181-1-git-send-email-abailon@baylibre.com>
 <20161209185421.fybpk4bdq6b7yglf@pengutronix.de>
 <e548f7cf-a1d5-0bc2-1095-db8464a1bcc4@ti.com>
 <35adff3d-c6a6-7b65-fb61-6da447dd6c3f@baylibre.com>
Message-ID: <e004a3f8-2dde-b21c-b09e-da5a65d768f6@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2016 04:27 AM, Alexandre Bailon wrote:
> On 12/12/2016 10:02 AM, Sekhar Nori wrote:
>> Hi Uwe,
>>
>> On Saturday 10 December 2016 12:24 AM, Uwe Kleine-K?nig wrote:
>>> Hello,
>>>
>>> On Fri, Dec 09, 2016 at 05:59:32PM +0100, Alexandre Bailon wrote:
>>>> Rename __clk_{enable|disble} in davinci_clk_{enable|disable}.
>>>> davinci_clk_{enable|disable} is a lock-less version of
>>>> clk_{enable|disable}.
>>>> This is useful to recursively enable clock without doing recursive call
>>>> to clk_enable(), which would cause a recursive locking issue.
>>>> The lock-less version could be used by example by the usb20 phy clock,
>>>> that need to enable the usb20 clock before to start.
>>>
>>> I wouldn't call that lock-less. The difference is that the newly exposed
>>> funcion requires the caller to already hold the lock. So maybe a better
>>
>> Right.
> Is it enough to update the commit message or should I also update the
> patch title?
> If so, could you suggest one because I don't know how to describe it
> shortly.

How about... "ARM: davinci: Make __clk_{enable,disable} functions public"





>
> Thanks,
> Alexandre
>
