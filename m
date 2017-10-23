From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 23 Oct 2017 16:59:54 +0100
Subject: [RESEND][PATCH 1/4] of: platform: populate /firmware/ node from
 of_platform_default_populate_init()
In-Reply-To: <CAL_JsqJYNXoZbN4zydkkZHWYxJuH4ObYJGgz2L7++kMgTWC1vg@mail.gmail.com>
References: <1506595562-10592-1-git-send-email-sudeep.holla@arm.com>
 <1506595562-10592-2-git-send-email-sudeep.holla@arm.com>
 <CAL_JsqJYNXoZbN4zydkkZHWYxJuH4ObYJGgz2L7++kMgTWC1vg@mail.gmail.com>
Message-ID: <52ed3abb-6b05-89c9-5ab4-31b37ffa1db9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 17/10/17 14:02, Rob Herring wrote:
> On Thu, Sep 28, 2017 at 5:45 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> Since "/firmware" does not have its own "compatible" property as it's
>> just collection of nodes representing firmware interface, it's sub-nodes
>> are not populated during system initialization.
>>
>> Currently different firmware drivers search the /firmware/ node and
>> populate the sub-node devices selectively. Instead we can populate
>> the /firmware/ node during init to avoid more drivers continuing to
>> populate the devices selectively.
>>
>> To generalize the solution this patch populates the /firmware/ node
>> explicitly from of_platform_default_populate_init().
>>

You had concernsin the past and I mentioned that firmware interface to
user-space *has* to continue in /sys/firmware, but he platform_device
management is internal to kernel.

Can we proceed with this change at-least for qcom and meson firmware
which are platform device already ? I can drop optee related changes.

-- 
Regards,
Sudeep
