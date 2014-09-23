From: peter.maydell@linaro.org (Peter Maydell)
Date: Tue, 23 Sep 2014 15:01:09 +0100
Subject: [GIT PULL] arm/arm64: KVM: Fix unaligned access bug on gicv2
 access
In-Reply-To: <20140923135241.GI12187@cbox>
References: <1411420350-368-1-git-send-email-christoffer.dall@linaro.org>
 <1411420350-368-2-git-send-email-christoffer.dall@linaro.org>
 <20140922220710.GA24499@arm.com> <5421310E.9020902@redhat.com>
 <20140923111412.GG12187@cbox> <54215E6D.6090308@redhat.com>
 <54216B1B.2010205@arm.com> <20140923135241.GI12187@cbox>
Message-ID: <CAFEAcA8pYezWttDHRpoNYn0wWvHg5M2xQLE4-D84uDC37k8emQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 September 2014 14:52, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> If anyone feels like reviewing my patch and giving it a quick test on a
> BE system with a version of QEMU with the pl011 level-triggered patch,

FWIW, any old version of QEMU running the vexpress-a15 model
will also use level-triggered interrupts for pl011, because
the upstream DTB which we use for that board has always
correctly marked the pl011 and all the other motherboard
devices as being level-triggered.

I'm still not 100% convinced we shouldn't mark the
virtio-mmio devices as level-triggered, incidentally.
I *think* that (a) the spec pretty heavily implies that
the lines behave as level triggered but (b) the
specific text in the spec about required guest code
to avoid races (s.2.4.2 of the 0.9.5 spec) means that
even if the interrupt controller treats them as edge
triggered it's OK.

-- PMM
