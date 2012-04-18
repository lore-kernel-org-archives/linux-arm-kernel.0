From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Apr 2012 16:12:33 +0100
Subject: [PATCH 7/7] MMC: mmci: Add required documentation for Device
 Tree bindings
In-Reply-To: <1334759484.26922.11.camel@hornet>
References: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
 <1334325909-5779-8-git-send-email-lee.jones@linaro.org>
 <1334759484.26922.11.camel@hornet>
Message-ID: <4F8ED9E1.8060604@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/04/12 15:31, Pawel Moll wrote:
> On Fri, 2012-04-13 at 15:05 +0100, Lee Jones wrote:
>> +Required properties:
>> +- arm,primecell-periphid : contains the PrimeCell Peripheral ID.
>
> I'd say that this is _very_ optional (as in: don't use this, unless you
> know what are you doing ;-)

Okay.

Who is pulling this patch by the way? Chris is it you?

I'll draft another one with the arm,primecell-periphid moved to optional 
properties and reply to the original [PATCH 7/7] mail with Arnd's Acked-by.

> Also, how are you planning to represent the ".ocr_mask" part of the
> platform data? (I'm asking about this particular one, because it's the
> only I need on vexpress ;-)

Short answer; I'm not.

Long answer; I'm not ... until the DMA mess is sorted out. Once it is, 
I'll use the correct bindings to associate DMA settings with the device. 
Until this time the ocr_mask (operation conditions register mask - see 
Russell, I'm learning ;)) will continue to be set using platform code. 
If you require it before that point, I have no qualms with you adding it 
yourself. :D

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
