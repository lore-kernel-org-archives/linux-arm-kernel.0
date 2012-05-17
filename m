From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 17 May 2012 12:23:08 +0530
Subject: [PATCHv2 11/19] ARM: OMAP4: PM: save/restore CM L3INSTR registers
 when MPU hits OSWR/OFF mode
In-Reply-To: <87sjez67i4.fsf@ti.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
 <1336990730-26892-12-git-send-email-t-kristo@ti.com> <87sjez67i4.fsf@ti.com>
Message-ID: <CAMQu2gxqkCzGZfn-X1e+n=07iZ75qk30udPUk+VPjaZAgQPqLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2012 at 4:47 AM, Kevin Hilman <khilman@ti.com> wrote:
> Tero Kristo <t-kristo@ti.com> writes:
>
>> From: Rajendra Nayak <rnayak@ti.com>
>>
>> On HS devices on the way out of MPU OSWR and OFF ROM code wrongly
>> overwrites the CM L3INSTR registers. So to avoid this, save them and
>> restore on the way out from MPU OSWR/OFF.
>>
>> This errata applies to all HS/EMU versions of OMAP4.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> [t-kristo at ti.com: added omap4 pm errata support]
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>
> Let's use the cluster PM notifiers here too, using the PM errata check
> when registering the notifier.
>
Good idea.
