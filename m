From: robherring2@gmail.com (Rob Herring)
Date: Fri, 13 Jun 2014 09:29:16 -0500
Subject: [RFC v3 1/9] arm: fiq: arbitrary mappings from IRQ to FIQ virqs
In-Reply-To: <1401961994-18033-2-git-send-email-daniel.thompson@linaro.org>
References: <1400853478-5824-1-git-send-email-daniel.thompson@linaro.org>
 <1401961994-18033-1-git-send-email-daniel.thompson@linaro.org>
 <1401961994-18033-2-git-send-email-daniel.thompson@linaro.org>
Message-ID: <CAL_JsqK-jCQjCCw4qfJOCfNKLVRDTAYSYsGpmYLDzoSVsBaHrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 5, 2014 at 4:53 AM, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
> Currently enable_fiq/disable_fiq use a simple offset to convert an IRQ
> virq into a FIQ virq. This is too inflexible for multi-platform kernels
> and makes runtime error checking impossible.
>
> We solve this by introducing a flexible mapping that allows interrupt
> controllers that support FIQ to register those mappings. This, in turn,
> makes it much possible for drivers in DT kernels to gain access to
> FIQ virqs.

I don't get why you need a separate linux irq numbers for FIQ. Isn't
enabling FIQ simply a property of an irq like edge vs. level trigger?
Also, given the constraints on FIQ, we can't really have more that 1
IRQ assigned to FIQ.

Rob
