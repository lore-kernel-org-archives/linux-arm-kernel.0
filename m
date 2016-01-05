From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 5 Jan 2016 12:12:31 +0000
Subject: [PATCH 1/2] tty: amba-pl011: fix earlycon register offsets
In-Reply-To: <20151224164723.GK8644@n2100.arm.linux.org.uk>
References: <1450972189-22639-1-git-send-email-timur@codeaurora.org>
 <20151224164723.GK8644@n2100.arm.linux.org.uk>
Message-ID: <CAPKp9ubdS+R8U-W+LxYEp_sGxZVBDGBJ48+N7Pw3k9A+=F4pww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Thu, Dec 24, 2015 at 4:47 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Dec 24, 2015 at 09:49:48AM -0600, Timur Tabi wrote:
>> The REG_x macros are indices into a table, not register offsets.  Since
>> earlycon does not have access to the vendor data, we can currently only
>> support standard ARM PL011 devices.
>>
>> Signed-off-by: Timur Tabi <timur@codeaurora.org>
>
> Please credit me with the change; this was obviously a change I made
> when I posted the updated patches, which Greg had failed to take
> instead of the original set.  Thanks.
>

I don't see this patch in linux-next. Without this it fails to boot(panics) on
ARM64 when earlycon is enabled. Also I think this fix might not be correct
for  ZTE pl011, though it works for ST and standard PL011.

Also since there's no logs on serial, it difficult to identify the
issue and better
to have some solution in place before many people start hitting this issue.

Regards,
Sudeep
