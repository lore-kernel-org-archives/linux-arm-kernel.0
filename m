From: peter.maydell@linaro.org (Peter Maydell)
Date: Mon, 1 Sep 2014 11:11:10 +0100
Subject: [PATCH 06/16] KVM: Add KVM_EXIT_SYSTEM_EVENT to user space API
 header
In-Reply-To: <20140901095629.GF19836@cbox>
References: <1401041942-23471-1-git-send-email-christoffer.dall@linaro.org>
 <1401041942-23471-7-git-send-email-christoffer.dall@linaro.org>
 <CAFEAcA-yWadPiE4v7f-C1-V71=QHYLB=fzC78xhNMnNkVSJAhg@mail.gmail.com>
 <20140901092017.GC19836@cbox>
 <CAFEAcA_S9dHbYVDrkr7X+cTcg-TC0nRWd4zLaUTX2zBjr+TKGQ@mail.gmail.com>
 <20140901095629.GF19836@cbox>
Message-ID: <CAFEAcA8k6M9_9_UE7QY9yHb2_mRGPsQfhVu=n1kpotOVQXqwqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 September 2014 10:56, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> The thing is that we're not exposing PSCI to user space, we're just
> exposing a system event, so it feels a bit weird to rely on user space's
> correct interpretation of a more generic API, to correctly implement
> PSCI in the kernel.

Yeah; if somebody wants to argue that the other set of semantics
make more sense considered purely as a KVM kernel-to-user
API I have no objection. (QEMU's current "we'll do that at some
point in the future" implementation follows the typical semantics
for reset/shutdown triggered by a device register write I think:
the write-to-device-register instruction will generally complete
and CPU execution continue before the prodded device can
get the system reset process done. But we don't necessarily
need to be bound by that idea.)

-- PMM
