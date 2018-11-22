From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 22 Nov 2018 12:59:10 +0000
Subject: [RFC PATCH v2 11/23] KVM: arm64: Support runtime sysreg filtering
 for KVM_GET_REG_LIST
In-Reply-To: <20181122123424.GG17441@e113682-lin.lund.arm.com>
References: <1538141967-15375-1-git-send-email-Dave.Martin@arm.com>
 <1538141967-15375-12-git-send-email-Dave.Martin@arm.com>
 <20181102081625.GS12057@e113682-lin.lund.arm.com>
 <20181115172711.GQ3505@e103592.cambridge.arm.com>
 <20181122105344.GF17441@e113682-lin.lund.arm.com>
 <CAFEAcA8UEqxM7KJGm81ETgPpsO6ByK7Vc9SuCKr4FZGVU8vxxg@mail.gmail.com>
 <20181122123424.GG17441@e113682-lin.lund.arm.com>
Message-ID: <CAFEAcA_G1ceUGnDX5u6bK_pX_7-tAHtP8+NkAkK-vKOhzC1hyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 November 2018 at 12:34, Christoffer Dall <christoffer.dall@arm.com> wrote:
> So on migration, will you have the required information for
> KVM_ARM_VCPU_INIT before setting the registers from the migration
> stream?
>
> (I assume so, because presumably this comes from a command-line switch
> or from the machine definition, which must match the source.)

Yes. QEMU always sets up the VCPU completely before doing any
inbound migration.

> Therefore, I don't think there's an issue with this patch, but from
> bitter experience I think we should enforce ordering if possible.

Yes, if there are semantic ordering constraints on the various
calls it would be nice to have the kernel enforce them.

thanks
-- PMM
