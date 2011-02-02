From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 02 Feb 2011 16:36:33 +0300
Subject: [PATCH v1 1/4] davinci: da8xx/omap-l1: add support for SPI
In-Reply-To: <4D495A54.2090702@criticallink.com>
References: <1296596979-18524-1-git-send-email-michael.williamson@criticallink.com>
	<1296596979-18524-2-git-send-email-michael.williamson@criticallink.com>
	<4D494C6A.30507@mvista.com> <4D49543A.1070302@criticallink.com>
	<4D495662.3060302@mvista.com> <4D495A54.2090702@criticallink.com>
Message-ID: <4D495DE1.6000808@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 02-02-2011 16:21, Michael Williamson wrote:

>>>>> Add SPI registration routines, clocks, and driver resources for
>>>>> DA850/OMAP-L138/AM18x and DA830/OMAP-L137/AM17x platforms.

>>>>      You're only adding clocks for the former platform -- the ones for the latter platfrom are already there...

>>>>> Signed-off-by: Michael Williamson<michael.williamson@criticallink.com>
>>>> [...]

>>>>> +    [4] = {
>>>>> +        .flags    = IORESOURCE_DMA,
>>>>> +    },

>>>>      BTW, why do you need this placeholder?

>>> This is for the eventq selection in the edma allocation by the spi driver.  When I
>>> previously had 0, I should have used EVENTQ_0 (how it was tested).  I will add it
>>> back in to clarification.

>>     But event queue is not a DMA channel, so can't have just IORESOURCE_DMA in 'flags'. IIUC,

    IIRC, I meant to type.

> there was a patch to add some clarifying flag(s) to IORESOURCE_DMA to support the event queue resource (which I never approved :-).


> I'd like to get the support in there for the driver that's currently in
> the mainline, which needs this resource as it is.  I had essentially copied
> the setup approach from the dm365.c board file, which is doing the same thing.

> It looks like other devices take EVENTQ information as platform data (e.g.,
> snd_platform_data takes .asp_chan_q).  Would it make sense to update the
> spi platform data to accept an EVENTQ parameter as well?

    Yes, as the event queue is not really a DMA resource (DMA channels are).

> Thanks.

WBR, Sergei
