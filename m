From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 28 Apr 2016 07:46:09 +0100
Subject: [Query] Does Linux & Qemu support KVM for ARM32 guest on
 ARM64 host
In-Reply-To: <708585848.188261461823397987.JavaMail.weblogic@ep2mlwas06d>
References: <708585848.188261461823397987.JavaMail.weblogic@ep2mlwas06d>
Message-ID: <CAFEAcA9eEdNhPSWgM39WoySe29+wLUz687PBDptHM20GwZC9Gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 April 2016 at 07:03, RAVINDRA KUMAR SANDE <r.sande@samsung.com> wrote:
> I have another query, for Arm32 host with KVM enabled.
> I see that "qemu-system-arm  -enable-kvm   -machine vexpress-a9  ..." gives error
> kmv_init_vcpu (IOCtl on /dev/kvm) failed, guest not supported.
>
> Is there any way to emulate vexpress-a9  with  -enable-kvm   on qemu ?

No. You can only emulate a CPU of the same type as the host
you're using, and the vexpress-a9 must use a Cortex-A9 CPU,
so it can't be used under virtualization.

thanks
-- PMM
