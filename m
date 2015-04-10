From: peter.maydell@linaro.org (Peter Maydell)
Date: Fri, 10 Apr 2015 11:01:36 +0100
Subject: [RFC PATCH] arm64: KVM: remove fpsimd save/restore from the world
 switch
In-Reply-To: <552793CF.8050904@arm.com>
References: <1428598439-5217-1-git-send-email-marc.zyngier@arm.com>
 <55278CAD.70302@redhat.com> <552793CF.8050904@arm.com>
Message-ID: <CAFEAcA8J-kDHjkg9uFbHHAEu=zSSv+CB1Vmy1JBh==SmeiWL1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 April 2015 at 10:11, Marc Zyngier <marc.zyngier@arm.com> wrote:
> I did some experimentations on arm64 a long while ago (see the
> kvm-arm64/lazy-fp branch in my tree), and it wasn't that great,
> apparently because aarch64 userspace tends to be much more FP happy than
> aarch32, but I'm not completely sure about it.

Was that with the buggy version of the toolchain that had
incorrect costs and so was much more inclined to spill
integer values into the FPU than it should have been?
It might be worth retesting with a freshly compiled
userspace some day...

-- PMM
