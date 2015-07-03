From: peter.maydell@linaro.org (Peter Maydell)
Date: Fri, 3 Jul 2015 10:34:38 +0100
Subject: [PATCH] arm64/kvm: Add generic v8 KVM target
In-Reply-To: <559647A7.7010309@arm.com>
References: <1434531646-4873-1-git-send-email-suzuki.poulose@arm.com>
 <CAFEAcA92uymQ3LjPQnuFiwvjSgc+jY54VrfK_Sh4v1DJ+=OPpw@mail.gmail.com>
 <558A6A84.5020603@arm.com> <20150624085128.GA22785@cbox>
 <558A7936.7020109@arm.com>
 <20150625123034.GE28244@cbox> <558BF6C9.3000009@arm.com>
 <558C05A9.8080201@arm.com>
 <CAFEAcA_ULz=ugQW=NmthzqYRtvcfwteQTh0DonHRN6U5NykEtQ@mail.gmail.com>
 <20150626095318.GG28244@cbox>
 <F37C68A5-E48F-462C-AD18-0F3C096348C7@caviumnetworks.com>
 <559180CA.3050905@arm.com>
 <CAFEAcA-E+KdiL4suQ0DoEvB-zGpNZ7-dq46FegC_iXYRPvo9jA@mail.gmail.com>
 <559185D4.7060308@arm.com>
 <85D36B67-643B-407F-944F-D18D54FF9909@caviumnetworks.com>
 <D805D093-CCFE-4835-853A-B2654DAA10A1@caviumnetworks.com>
 <559642EE.1050605@arm.com>
 <CAFEAcA8nt7yr0K4QesJjWqEwBgziWOt2DViY70E=z2wjt=X7XA@mail.gmail.com>
 <559647A7.7010309@arm.com>
Message-ID: <CAFEAcA-XyGRLSdQSye5OP6vRQKLZtMY4Erg7jfcpr-oo-HqJ7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 July 2015 at 09:28, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 03/07/15 09:12, Peter Maydell wrote:
>> I would still like to see the proponents of this patch say
>> what their model is for userspace support of cross-host migration,
>> if we're abandoning the model the current API envisages.
>
> I thought we had discussed this above, and don't really see this as a
> departure from the current model:
>
> - "-cpu host" results in "GENERIC" being used: VM can only be migrated
> to the exact same HW (no cross-host migration). MIDR should probably
> become RO.
> - "-cpu host" results in "A57" (for example): VM can be migrated to a
> variety of A57 platforms, and allow for some fuzzing on the revision (or
> accept any revision).
> - "-cpu a57" forces an A57 model to be emulated, always. It is always
> possible to migrate such a VM on any host.
>
> I think only the first point is new, but the last two are what we have
> (or what we should have).

Right, but the implicit idea of this GENERIC patch seems to
be that new host CPU types don't get their own KVM_ARM_TARGET_*
constant, and are thus forever unable to do cross-host migration.
It's not clear to me why we'd want to have new CPUs be second
class citizens like that.

-- PMM
