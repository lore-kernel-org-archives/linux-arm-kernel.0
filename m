From: davidb@codeaurora.org (David Brown)
Date: Thu, 07 Mar 2013 10:50:40 -0800
Subject: [PATCH 1/6] platform-drivers: msm: add single-wire serial bus
 interface (SSBI) driver
In-Reply-To: <20130307060117.GA31687@kroah.com> (Greg Kroah-Hartman's message
 of "Thu, 7 Mar 2013 14:01:17 +0800")
References: <1362616187-21089-1-git-send-email-davidb@codeaurora.org>
 <1362616187-21089-2-git-send-email-davidb@codeaurora.org>
 <20130307013008.GA2910@kroah.com> <8yawqtjvl8y.fsf@huya.qualcomm.com>
 <20130307060117.GA31687@kroah.com>
Message-ID: <8yafw07ujr3.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

>> Without this device, the PMIC drivers won't work, regulators can't be
>> turned on, and most of the other devices won't work.  I can try if it
>> can still be made a module, and it might be good at exercising the
>> deferred probe mechanism.
>
> If the PMIC drivers are dependant on the symbols in this module, there
> should not be any problems, right?

The PMIC drivers directly will be, but the users of gpios/irqs and
regulators coming from the PMIC will only depend on the generic APIs for
this.  In theory, the deferred probe should handle this, and it might
be useful for testing.

I can allow it to be a module, although I don't picture that really
being a useful configuration.

David

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
