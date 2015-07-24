From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 24 Jul 2015 10:07:03 +0100
Subject: inquiries on juno
In-Reply-To: <CAN2waFugZ869RZe_3GbW+8qCZQL-h9fRt5g38JJUPkr8f8VR5A@mail.gmail.com>
References: <CAN2waFugZ869RZe_3GbW+8qCZQL-h9fRt5g38JJUPkr8f8VR5A@mail.gmail.com>
Message-ID: <55B20037.2090705@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 24/07/15 03:05, Zhaoyang Huang wrote:
> Dear ARM guys,
> I am HuangZhaoyang who is assignee engineer of linaro. I would like
> raise one problem which I find on juno board. Please help to check it
> when convenient. That is,
> The upstreaming kernel(v4.1 form torvalds's tree) can not boot up on
> juno. The terminal show bellowing logs and hung up then.
>
> Shell> Image dtb=juno/juno.dtb console=ttyAMA0,115200 rootwait
> root=/dev/sda2
> EFI stub: Booting Linux Kernel...
> EFI stub: Using DTB from command line
> EFI stub: Exiting boot services and installing virtual address map...
>

Please use the upstream dtb if you are not already. The downstream
kernel once carried a hack for memory mapped timer and had it enabled in
DT. However the upstream DTB doesn't enable the broken timer and it
should resolve your boot issue.

Regards,
Sudeep
