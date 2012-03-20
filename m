From: khilman@ti.com (Kevin Hilman)
Date: Tue, 20 Mar 2012 15:48:45 -0700
Subject: [PATCH v8 0/8] Consolidate cpuidle functionality
In-Reply-To: <201203202158.08042.arnd.bergmann@linaro.org> (Arnd Bergmann's
 message of "Tue, 20 Mar 2012 21:58:07 +0000")
References: <1332274969-15782-1-git-send-email-rob.lee@linaro.org>
 <201203202158.08042.arnd.bergmann@linaro.org>
Message-ID: <873992zy5u.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd.bergmann@linaro.org> writes:

> On Tuesday 20 March 2012, Robert Lee wrote:
>> This patch series moves various functionality duplicated in platform 
>> cpuidle drivers to the core cpuidle driver. Also, the platform irq
>> disabling was removed as it appears that all calls into 
>> cpuidle_call_idle will have already called local_irq_disable().
>> 
>> These changes have been pulled into linux-next.
>> 
>> Len, Andrew, can a request be made for Linus to pull these changes?
>
> FWIW, Len seems to be rather inactive on the kernel mailing list right
> now and generally not very interested in anything outside of x86 and
> acpi. If he doesn't reply in the next few days and Andrew also isn't
> interested in handling these patches, I'd suggest you just send the pull
> request to Linus, with Len on Cc and explain that you tried to send
> them through him but gave up in the end.

FWIW, I have not had good luck getting response for proposed core
CPUidle changes either:

        http://lkml.org/lkml/2011/9/19/374

Maybe it's time that drivers/cpuidle gets a maintainer.  With lots of
discussions of scheduler changes that affect load estimation, I suspect
we're all going to have a bit of CPUidle work to do in the
not-so-distant future.
 
Kevin
