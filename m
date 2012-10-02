From: will.deacon@arm.com (Will Deacon)
Date: Tue, 2 Oct 2012 20:28:06 +0100
Subject: [kvmarm] [PATCH v2 08/10] ARM: KVM: VGIC initialisation code
In-Reply-To: <CAFEAcA8Mvh3QzVYTAhLjjbgCqd_AjJ7ji9z7NoLWnM4YUW0OQw@mail.gmail.com>
References: <20121001091244.49503.96318.stgit@ubuntu>
 <20121001091426.49503.94722.stgit@ubuntu>
 <20121002092412.GB8847@mudshark.cambridge.arm.com>
 <b4b11d71544812cff978b3457a99b90e@localhost>
 <C24866D7-ED20-402F-B769-1FE4D5561C77@virtualopensystems.com>
 <CAFEAcA8Mvh3QzVYTAhLjjbgCqd_AjJ7ji9z7NoLWnM4YUW0OQw@mail.gmail.com>
Message-ID: <20121002192806.GC20411@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 02, 2012 at 07:31:43PM +0100, Peter Maydell wrote:
> We probably want to be passing in the "base of the cpu-internal
> peripherals", rather than "base of the GIC" specifically. For the
> A15 these are the same thing, but that's not inherent [compare the
> A9 which has more devices at fixed offsets from a configurable
> base address].

If you do that, userspace will need a way to probe the emulated CPU so
that is knows exactly which set of peripherals there are and which ones it
needs to emulate. This feels pretty nasty, given that the vgic is handled
more or less completely by the kernel-side of things.

Will
