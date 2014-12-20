From: peter.maydell@linaro.org (Peter Maydell)
Date: Sat, 20 Dec 2014 22:54:52 +0000
Subject: [PATCH v2 3/4] arm64: dts: Add mediatek MT8173 SoC and evaluation
 board dts and Makefile
In-Reply-To: <3669965.zfJEHTFEBI@wuerfel>
References: <1418825853-10934-1-git-send-email-eddie.huang@mediatek.com>
 <20141217143305.GC8942@leverpostej> <54919AC9.2090306@arm.com>
 <3669965.zfJEHTFEBI@wuerfel>
Message-ID: <CAFEAcA-+2G_F1Qp30BipY=wq-HdXSvKv0OArOJBcp8fGg0hPMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 December 2014 at 20:07, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 17 December 2014 15:01:29 Marc Zyngier wrote:
>> Also it is worth noticing that given how GICV is placed, it will never
>> work with 64K pages and virtualization. Pretty sad.
>
> Does this mean no VGIC support on this platform so you have to emulate it
> in order to run virtual machines with 64K pages, or does it mean that
> it's impossible to use that way because you can't emulate it?

Currently having the guest use the generic timer requires an
in-kernel GIC, because we don't provide an ABI for having the
kernel say "here is a generic timer interrupt for the userspace
emulated GIC". And at least for QEMU userspace the "virt" board
doesn't provide any other kind of timer, so you'd need to add one
if you wanted to use a userspace GIC. So for practical purposes
"out-of-kernel GIC" is not a supported config for KVM+QEMU.

-- PMM
