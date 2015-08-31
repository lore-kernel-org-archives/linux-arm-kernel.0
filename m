From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 31 Aug 2015 11:02:53 +0200
Subject: [PATCH 9/9] arm/arm64: KVM: arch timer: Reset CNTV_CTL to 0
In-Reply-To: <20150831085752.GH24113@cbox>
References: <1440942866-23802-1-git-send-email-christoffer.dall@linaro.org>
 <1440942866-23802-10-git-send-email-christoffer.dall@linaro.org>
 <CAKv+Gu-4KKUUt7J==CPK6J79mWXLeMJFsG_fj85tYB2orzfrZg@mail.gmail.com>
 <20150831085752.GH24113@cbox>
Message-ID: <CAKv+Gu_f97gu+TftpdJDef4X89sjYB2udUybpmm=M113_TTiPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 August 2015 at 10:57, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> On Mon, Aug 31, 2015 at 10:46:59AM +0200, Ard Biesheuvel wrote:
>> On 30 August 2015 at 15:54, Christoffer Dall
>> <christoffer.dall@linaro.org> wrote:
>> > Provide a better quality of implementation and be architecture compliant
>> > on ARMv7 for the architected timer by resetting the CNTV_CTL to 0 on
>> > reset of the timer, and call kvm_timer_update_state(vcpu) at the same
>> > time, ensuring the timer output is not asserted after, for example, a
>> > PSCI system reset.
>> >
>> > This change alone fixes the UEFI reset issue reported by Laszlo back in
>> > February.
>> >
>>
>> Do you have a link to that report? I can't quite remember the details ...
>>
> There was no public mailing list cc'ed on the report, and the bugzilla
> bug was created in a non-public Red Hat instance.
>
> But you were cc'ed on the original mail from Laszlo.  Look for an e-mail
> from February 5th with the subject "virtual timer interrupt stuck across
> guest firmware reboot on KVM".
>

Found it, thanks.
