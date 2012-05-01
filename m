From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Tue, 1 May 2012 10:38:31 +0200
Subject: [PATCH v7 0/6] PM QoS: implement the OMAP low level constraints
 management code
In-Reply-To: <877gwwlsl3.fsf@ti.com>
References: <1334756720-29166-1-git-send-email-j-pihet@ti.com>
 <877gwwlsl3.fsf@ti.com>
Message-ID: <CAORVsuWMuSrxWvM37gCS4HqzCmHqVCq=H9Oe2G0U=OS15L=aiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Tue, May 1, 2012 at 1:15 AM, Kevin Hilman <khilman@ti.com> wrote:
> Hi Jean,
>
> jean.pihet at newoldbits.com writes:
>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> . Implement the devices wake-up latency constraints using the global
>> ? device PM QoS notification handler which applies the constraints to the
>> ? underlying layer,
>> . Implement the low level code which controls the power domains next
>> ? functional power states [3], through the hwmod and pwrdm layers,
>> . Add cpuidle and power domains wake-up latency figures for OMAP3, cf.
>> ? comments in the code and [1] for the details on where the numbers
>> ? are magically coming from,
>> . Implement the relation between the cpuidle and per-device PM QoS frameworks
>> ? in the OMAP3 specific idle callbacks.
>> ? The chosen C-state shall satisfy the following conditions:
>> ? ?. the 'valid' field is enabled,
>> ? ?. it satisfies the enable_off_mode flag,
>> ? ?. the next state for MPU and CORE power domains is not lower than the
>> ? ? ?state programmed by the per-device PM QoS.
>
> I've just been through this series and it looks good to me.
>
> Reviewed-by: Kevin Hilman <khilman@ti.com>
Thx for reviewing!

>> ToDo:
>> 1. support OMAP4 chipset when the low power modes will be supported
>
> Have you been able to do this with Tero's latest CORE RET and device off
> series?
No I still have to port Tero's latest patch set on top of the
functional power states and the constraints code. This is on my
ToDoNext list ;p

>
> Kevin
>

Thanks,
Jean
