From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 23 Mar 2014 10:44:31 -0700
Subject: [PATCH v5 02/11] ARM/ARM64: KVM: Add base for PSCI v0.2 emulation
In-Reply-To: <CALrVBkvRqRWnnzgBYCLGwYbiOy-JnezgE=89nq8O3rvdv7RqFw@mail.gmail.com>
References: <1395406414-11707-1-git-send-email-anup.patel@linaro.org>
 <1395406414-11707-3-git-send-email-anup.patel@linaro.org>
 <20140321232704.GB25519@cbox>
 <CALrVBkvRqRWnnzgBYCLGwYbiOy-JnezgE=89nq8O3rvdv7RqFw@mail.gmail.com>
Message-ID: <20140323174431.GE30885@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 22, 2014 at 09:54:55AM +0530, Anup Patel wrote:
> On 22 March 2014 04:57, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> > On Fri, Mar 21, 2014 at 06:23:25PM +0530, Anup Patel wrote:
> >> Currently, the in-kernel PSCI emulation provides PSCI v0.1 interface to
> >> VCPUs. This patch extends current in-kernel PSCI emulation to provide
> >> PSCI v0.2 interface to VCPUs.
> >>
> >> By default, ARM/ARM64 KVM will always provide PSCI v0.1 interface for
> >> keeping the ABI backward-compatible.
> >>
> >> To select PSCI v0.2 interface for VCPUs, the user space (i.e. QEMU or
> >> KVMTOOL) will have to set KVM_ARM_VCPU_PSCI_0_2 feature when doing VCPU
> >> init using KVM_ARM_VCPU_INIT ioctl.
> >>
> >> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> >> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> >
> > The content here can carry my Reviewed-by tag, but I think Rob's point
> > about sharing this code between KVM arm/arm64 and the PSCI code itself
> > it important, see:
> >
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2014-March/241792.html
> 
> My apologies, I totally missed Rob's comment.

No worries at all.

> 
> My suggestion would be to have:
> arch/arm/include/uapi/asm/psci.h
> arch/arm64/include/uapi/asm/psci.h

I think the suggestion was to move all this to include/uapi/linux/psci.h
or something equivalent so also arm and arm64 can share these defines,
but maybe I read too much into it.

Rob?
