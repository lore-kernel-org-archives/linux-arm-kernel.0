From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 31 Mar 2014 11:36:29 -0700
Subject: [PATCH v6 02/12] ARM/ARM64: KVM: Add common header for PSCI
 related defines
In-Reply-To: <CAJ5Y-eaGsM4Moz815P7QM=7qh87RyzU-MVyeLOT64CLEaR0HQA@mail.gmail.com>
References: <1396262773-7723-1-git-send-email-anup.patel@linaro.org>
 <1396262773-7723-3-git-send-email-anup.patel@linaro.org>
 <20140331180722.GD4756@lvm>
 <CAJ5Y-eaGsM4Moz815P7QM=7qh87RyzU-MVyeLOT64CLEaR0HQA@mail.gmail.com>
Message-ID: <20140331183629.GF4756@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 31, 2014 at 02:18:20PM -0400, Ashwin Chaugule wrote:
> Hello,
> 
> On 31 March 2014 14:07, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> > On Mon, Mar 31, 2014 at 04:16:03PM +0530, Anup Patel wrote:
> >> We need a common place to share PSCI related defines among ARM kernel,
> >> ARM64 kernel, KVM ARM/ARM64 PSCI emulation, and user space.
> >>
> >> We introduce uapi/linux/psci.h for this purpose. This newly added
> >> header will be first used by KVM ARM/ARM64 in-kernel PSCI emulation
> >> and user space (i.e. QEMU or KVMTOOL).
> >>
> >> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> >> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> >> ---
> >>  include/uapi/linux/Kbuild |    1 +
> >>  include/uapi/linux/psci.h |   55 +++++++++++++++++++++++++++++++++++++++++++++
> >>  2 files changed, 56 insertions(+)
> >>  create mode 100644 include/uapi/linux/psci.h
> >>
> >
> > You should coordinate with Ashwin's work so you don't step on each
> > other's definitions and one patch set should depend on the other one.
> 
> So, apart from some extra #defines we mostly differ on style. Whats
> the general recommendation here?
> Mine looks simpler [1] ;)
> 
I think Marc brought up the point previously that we may get to PSCI
spec v42.17 and the defines should perhaps encompass the version we are
defining things for right now...

That being said, assuming new spec versions don't break backwards
compatibility in the numbering, the wording proposed by your patch does
look simpler.

I do like the hardcoded IDs because that's how it's presented in the
spec itself.

-Christoffer
