From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 20 Sep 2016 14:15:51 +0100
Subject: [PATCH] tty: amba-pl011: uart_amba_port is not available with
 earlycon function
In-Reply-To: <20160920130504.GF3744@tiger>
References: <1474092878-30034-1-git-send-email-shawn.guo@linaro.org>
 <20160920130504.GF3744@tiger>
Message-ID: <5f503859-0bf3-e031-450b-2597d93e05ce@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 20/09/16 14:05, Shawn Guo wrote:
> On Sat, Sep 17, 2016 at 02:14:38PM +0800, Shawn Guo wrote:
>> Commit 0e125a5facf8 ("tty: amba-pl011: define flag register bits for ZTE
>> device") changes earlycon function pl011_putc() to use a pointer to
>> uart_amba_port.  This causes a regression when earlycon is enabled,
>> because uart_amba_port is not available yet at earlycon time.  Let's
>> revert the change on pl011_putc() to fix the regression.
>>
>> The earlycon support for ZTE device can probably be added later by
>> declaring a new earlycon setup function with a vendor specific
>> compatible.
>>
>> Reported-by: Sudeep Holla <sudeep.holla@arm.com>
>> Fixes: 0e125a5facf8 ("tty: amba-pl011: define flag register bits for ZTE device")
>> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>
> Hi Sudeep,
>
> Can you please confirm if the patch fixes your problem, so that Greg
> knows whether it should be applied?  Thanks.
>

Sorry, since it's basically what I tried first before posting some patch
using private_data, I assumed it will work.

Anyways I have now tested it, so you can add:
Tested-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
