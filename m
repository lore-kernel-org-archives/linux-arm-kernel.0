From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 7 May 2015 13:34:10 +0100
Subject: [Discussion] how to implement external power down for ARM
In-Reply-To: <554B5830.2090600@huawei.com>
References: <55417F5A.4040300@linaro.org> <20501959.OF3FLWO2Eh@wuerfel>
 <554B2DF5.4040600@huawei.com> <4412805.fx6caR2qJ7@wuerfel>
 <554B5627.100@huawei.com>
 <CAFEAcA-E=s3fhKAe4XS=rVdqw8HUO7EvqM7_C_oob1Kbg3MDGw@mail.gmail.com>
 <554B5830.2090600@huawei.com>
Message-ID: <CAFEAcA_EJSm_OHxsGvDfydacHHz=RcvrHHCg_LEFpLCBUxHmtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 May 2015 at 13:18, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
> On 2015/5/7 20:12, Peter Maydell wrote:
>> On 7 May 2015 at 13:10, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
>>> BTW, IIUC QEMU doesn't support the gracefully reboot support. The reboot
>>> depends on libvirt or other management tools. So the reboot case in
>>> virtualization is firstly poweroff, then start again.
>>
>> I'm not sure what you mean by this -- QEMU supports 'reset this
>> VM' at the machine emulation level, so if we can tell the guest
>> to reboot then it should as part of this process issue the
>> PSCI SYSTEM_RESET command, which QEMU/KVM will then handle
>> to do a reset of the VM.

> Yes, QEMU supports reset, but doesn't support (gracefully) reboot.

Isn't that what this ACPI work is about? Tell the guest to initiate
a graceful reboot, and then the guest will tell QEMU to reboot
the emulated h/w when it's ready.

> And
> reset doesn't depends on the guest, it just restart VM forcefully.
> Reboot likes poweroff and start, while reset likes destroy and start.

I (and QEMU) think there is no visible difference between
poweroff-and-restart and destroy-recreate-and-restart...

-- PMM
