From: adrienverge@gmail.com (=?UTF-8?Q?Adrien_Verg=C3=A9?=)
Date: Thu, 5 Dec 2013 18:54:49 -0500
Subject: [PATCH 0/3] ARM Coresight: Enhance ETM tracing control
In-Reply-To: <52A101F8.3060104@codeaurora.org>
References: <CANsc=4VRLWhaVA15HrBEeM+FJC0tS+b5KKopDb7bP8nxzR8=zA@mail.gmail.com>
 <20131204070442.GA31665@kroah.com>
 <CANsc=4UHEG5cmg9SD3r3rsuJnM9zqq2WiTQdUwrYFr_kkbsVvg@mail.gmail.com>
 <20131204170703.GA14859@kroah.com>
 <CANsc=4X7ThCvgz9bfu1ZZg9FCti5SMdbXL5tA584z-oZ_HEByg@mail.gmail.com>
 <20131204230239.GB9205@kroah.com>
 <CANsc=4UGi5sMdUW5qQDzEJx4h8NDU+-b=xOLBAZtzbV5ugz3Fg@mail.gmail.com>
 <20131205040104.GA14641@kroah.com>
 <52A0DE42.3080602@codeaurora.org>
 <20131205201659.GA14539@kroah.com>
 <52A101F8.3060104@codeaurora.org>
Message-ID: <CANsc=4Vb-2br+K51NWsyQV25R3eJo_=YfpnXsh1G1ecRVDYc3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg and Christopher,

Thank you for your feedback.

2013/12/4 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> What is it's purpose then?  At first glance, this seems to be exactly
> what 'perf' provides already.  Doesn't perf work on ARM today?

On ARM, perf is unable to trace every instruction, and certainly not
recording the number of cycles taken by every of them. Also, ETM is
not just tracing the execution flow. It can trace data, trigger
tracing on events such as address matching, data matching, context ID
change, monitor CPRT... It would be sad not to use these capabilities.

If we want perf to use ETM's full functionality, its framework clearly
needs to be extended. Future Intel processors will embed Processor
Trace [1], which seems to have similar capabilities as ETM on ARM. At
that point, it will be easier to decide what should be in the kernel
or in perf.

I the meantime, while ETM is not supported elsewhere than in sysfs, it
should at least be configurable. The current implementation is almost
not usable.

> Well, these patches were incorrect, so that's not really a valid
> question :)

Should I correct the pid size and send them again?

Thanks,

Adrien

[1]: http://software.intel.com/en-us/blogs/2013/09/18/processor-tracing
