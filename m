From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 26 Feb 2016 07:47:32 -0800
Subject: [PATCH v4 0/6] watchdog: pnx4008: add restart handler
In-Reply-To: <1456500886.2194.6.camel@localhost>
References: <1456425100-28136-1-git-send-email-slemieux.tyco@gmail.com>
 <56D062DD.1060707@roeck-us.net> <1456500886.2194.6.camel@localhost>
Message-ID: <56D07394.8030107@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/26/2016 07:34 AM, Sylvain Lemieux wrote:
> On Fri, 2016-02-26 at 06:36 -0800, Guenter Roeck wrote:
>> On 02/25/2016 10:31 AM, Sylvain Lemieux wrote:
>>> From: Sylvain Lemieux <slemieux@tycoint.com>
>>>
>>> The LPC32xx provide the capability to perform a soft or hard reset;
>>> a soft reset will no reset the external peripheral
>>> (i.e. RESOUT_N output not asserted).
>>>
>>> This changeset migrate the restart code from the "mach-lpc32xx" to
>>> the "pnx-4008" watchdog driver and add the soft reset capability.
>>>
>>> The default behavior (i.e. hard reset) remain unchanged.
>>>
>>> The core restart handler support added by this change:
>>> 2165bf524da5f5e496d - "watchdog: core: add restart handler support"
>>> is not use in this changeset; it does not support the reboot mode.
>>
>> I finally had the time to look into this. Sorry for the late reply.
>>
>> Changing the watchdog core to pass the restart mode (or action)
>> and the cmd/data pointer to the driver would be trivial and should
>> be done instead.
>>
> Thanks for the feedback.
>
> Do you want me to rebase this patchset on the patch you will submit
> to update the core restart handler support?
>

Yes, please. I'll Cc: you on it.

If you want to get started early and are open to do some early testing,
try cloning git://kerneltests.org/git/linux.git. You'll find the patch
in branch 'testing'.

Thanks,
Guenter
