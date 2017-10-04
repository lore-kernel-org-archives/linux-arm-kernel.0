From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 4 Oct 2017 12:48:01 +0100
Subject: [PATCH v3 16/22] firmware: arm_scmi: add arm_mhu specific mailbox
 interface
In-Reply-To: <CAK8P3a0XmiXqZ-z7WV+nk7B86p23Jmf31Q=pVovXVebhA28_0Q@mail.gmail.com>
References: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
 <1506604306-20739-17-git-send-email-sudeep.holla@arm.com>
 <CAK8P3a0XmiXqZ-z7WV+nk7B86p23Jmf31Q=pVovXVebhA28_0Q@mail.gmail.com>
Message-ID: <f08a0355-ecbb-e685-4061-c9253440b390@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/10/17 12:36, Arnd Bergmann wrote:
> On Thu, Sep 28, 2017 at 3:11 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> This patch adds ARM MHU specific mailbox interface for SCMI.
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> This clearly needs an explanation why we need another driver.
> 
Yes, I understand. I myself is not convinced that we need one. Jassi
disagrees to add support to use each bit as doorbell in the ARM MHU
driver though the MHU specification states it clearly(3.4.4 Message
Handling Unit (MHU) of Juno TRM)[1].

This shim was added to deal with that with I agree is wrong IMO but
Jassi thinks that's right way to deal with it.

-- 
Regards,
Sudeep


[1]
http://infocenter.arm.com/help/topic/com.arm.doc.ddi0515f/DDI0515F_juno_arm_development_platform_soc_trm.pdf
