From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 7 May 2015 13:12:49 +0100
Subject: [Discussion] how to implement external power down for ARM
In-Reply-To: <554B5627.100@huawei.com>
References: <55417F5A.4040300@linaro.org> <20501959.OF3FLWO2Eh@wuerfel>
 <554B2DF5.4040600@huawei.com> <4412805.fx6caR2qJ7@wuerfel>
 <554B5627.100@huawei.com>
Message-ID: <CAFEAcA-E=s3fhKAe4XS=rVdqw8HUO7EvqM7_C_oob1Kbg3MDGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 May 2015 at 13:10, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
> BTW, IIUC QEMU doesn't support the gracefully reboot support. The reboot
> depends on libvirt or other management tools. So the reboot case in
> virtualization is firstly poweroff, then start again.

I'm not sure what you mean by this -- QEMU supports 'reset this
VM' at the machine emulation level, so if we can tell the guest
to reboot then it should as part of this process issue the
PSCI SYSTEM_RESET command, which QEMU/KVM will then handle
to do a reset of the VM.

-- PMM
