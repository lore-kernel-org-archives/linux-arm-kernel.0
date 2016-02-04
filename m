From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 4 Feb 2016 10:43:12 -0600
Subject: [PATCH v10 5/5] Watchdog: ARM SBSA Generic Watchdog half timeout
 panic support
In-Reply-To: <CANLsYkyLBfSKFM6CCyPP+Eaua2B+n80wL2hnQVSvfUNMPd3OdQ@mail.gmail.com>
References: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
 <1454519923-25230-6-git-send-email-fu.wei@linaro.org>
 <CANLsYkyLBfSKFM6CCyPP+Eaua2B+n80wL2hnQVSvfUNMPd3OdQ@mail.gmail.com>
Message-ID: <56B37FA0.5000209@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mathieu Poirier wrote:
>> >+#ifdef CONFIG_ARM_SBSA_WATCHDOG_PANIC
>> >+       irq = platform_get_irq(pdev, 0);
>> >+       if (irq < 0) {
>> >+               dev_err(dev, "unable to get ws0 interrupt.\n");
>> >+               return irq;
>> >+       }
>> >+#endif
>> >+
> Can't the driver revert to single stage mode if platform_get_irq()
> fails?  That way the value of 'irq' can be tested throughout the
> _probe() function and the #ifdefs removed.

I like that idea.  The same can be done with the devm_request_irq() 
call.  It should definitely still display a warning if the command-line 
option is set but no interrupt is available.
