From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 14 Feb 2012 12:45:11 +0530
Subject: [PATCH 1/2] ARM: OMAP: Get rid of reset for system timer
In-Reply-To: <4F39EDD0.9010304@ti.com>
References: <1328191435-18652-1-git-send-email-santosh.shilimkar@ti.com>
 <1328191435-18652-2-git-send-email-santosh.shilimkar@ti.com>
 <20120210191813.GU1426@atomide.com> <4F39EDD0.9010304@ti.com>
Message-ID: <CAMQu2gxnHE8fps6LD93B2G_w-p=i7YmuadasPrE-601-S8mUkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 14, 2012 at 10:44 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> On Saturday 11 February 2012 12:48 AM, Tony Lindgren wrote:
>>
>> * Santosh Shilimkar<santosh.shilimkar@ti.com> ?[120202 05:33]:
>>>
>>> > ?From: Rajendra Nayak<rnayak@ti.com>
>>> >
>>> > ?hwmod setup already does a reset and sets the OCP sysconfig
>>> > ?registers appropriately. Avoid doing a reset again and overriding
>>> > ?the OCP sysconfig settings in the system timer init code.
>
>>
>>
>> If we want this queued as a fix, it should also describe what
>> actually breaks? Timer? PM?
>
>
> It only fixes the redundant reset and overriding the smartidle-wakeup
> OCP setting (done by hwmod) with the smartidle in the driver.
> Doing this doesn't really break anything as yet in mainline, but will
> cause timer wakeup issues once OFF mode is in place for OMAP4. On OMAP5
> however this was causing more issues as the softreset bit position is
> different than on OMAP2/3/4.
> So it should be ok to queue this in for 3.4 considering neither OMAP4
> OFF, not OMAP5 support is in mainline yet.
>
I second Rajendra's comment.

Regards
Santosh
