From: peter.maydell@linaro.org (Peter Maydell)
Date: Mon, 15 Sep 2014 12:45:46 -0700
Subject: [PATCH 1/2] ARM: kvm: define PAGE_S2_DEVICE as read-only by
 default
In-Reply-To: <541740FF.2080105@samsung.com>
References: <1410603462-28900-1-git-send-email-ard.biesheuvel@linaro.org>
 <bcbc1c52f9e1eeb24f0bd1956236f0a3@www.loen.fr>
 <CAKv+Gu8J8o2=CS9tGVbkavHep6gNwSSegZ0fxqsVE2AVDVzdpA@mail.gmail.com>
 <20140913170638.GA3348@lvm>
 <CAKv+Gu93FkRWXd96gKdN+OCrUgjF0sXWL4ohishVWAO-XeR9Ww@mail.gmail.com>
 <fdc415c79e617d4e9102acc12a4c0d65@www.loen.fr>
 <CAKv+Gu-kce_1cg2fgj5Qj_kRMtzzHctofZ108531-UrcFLZAog@mail.gmail.com>
 <CAKv+Gu-MAkzFtrFk19mYB=jQyLsFLY+k3Ly=eZQ=3hWSALLRPw@mail.gmail.com>
 <541740FF.2080105@samsung.com>
Message-ID: <CAFEAcA9kZve_TRxi_5wjTZ34hG586G4gwV-TaW06K10NLZZvOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 September 2014 12:41, Mario Smarduch <m.smarduch@samsung.com> wrote:
> I've been working around the edges of this discussion, and
> maybe be little unclear on this.
>
> But the manuals say intersection of Stage1/Stage2 permissions are
> used. If guest sets stage1 to read-only then setting stage 2
> to read-only or read-write should have no impact. So why
> should stage 2 RW be changed?

Read versus read-write isn't relevant. The point is
that you mustn't let the guest set up a Normal memory
mapping of the same bit of hardware (phys. address
space) that some other guest or the host has set up
as Device mapping.

-- PMM
