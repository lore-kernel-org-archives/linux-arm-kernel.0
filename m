From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 23 Jul 2015 22:04:23 -0600
Subject: [PATCH] irqchip: bcm2835: Add FIQ support
In-Reply-To: <55AFA3BD.80507@tronnes.org>
References: <1434130016-26574-1-git-send-email-noralf@tronnes.org>
 <55822C71.2040409@wwwdotorg.org> <55AFA3BD.80507@tronnes.org>
Message-ID: <55B1B947.6080102@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/22/2015 08:07 AM, Noralf Tr?nnes wrote:
> 
> Den 18.06.2015 04:26, skrev Stephen Warren:
>> On 06/12/2015 11:26 AM, Noralf Tr?nnes wrote:
>>> Add a duplicate irq range with an offset on the hwirq's so the
>>> driver can detect that enable_fiq() is used.
>>> Tested with downstream dwc_otg USB controller driver.
>> This basically looks OK, but a few comments/thoughts:
>>
>> a) Should the Kconfig change be a separate patch since it's a separate
>> subsystem?
> 
> Is this a yes since you haven't acked it?

I didn't ack it because I thought there were still outstanding review
comments. Looking back at the thread, everything is resolved.

Acked-by: Stephen Warren <swarren@wwwdotorg.org>

Whether the driver and Kconfig patch need to be in separate patches
largely depends on who will merge it. If there's a desire to merge the
two parts through separate subsystems, separate patches will be needed,
else not. I'll leave that up to the IRQ subsystem maintainers and Lee
(or Eric) since they're actually merging the bcm2835 patches.
