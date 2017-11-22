From: will.deacon@arm.com (Will Deacon)
Date: Wed, 22 Nov 2017 19:37:19 +0000
Subject: [PATCH 00/18] arm64: Unmap the kernel whilst running in
 userspace (KAISER)
In-Reply-To: <CAKv+Gu8WPU=LKLR90WBpAey2VkCVuuTpQycsde-88G4F_B1wUQ@mail.gmail.com>
References: <1510942921-12564-1-git-send-email-will.deacon@arm.com>
 <CAKv+Gu8YB_qXgWEbd0ZZ6UycxNLXxTZCno87vJ9HH7d6+dKeLQ@mail.gmail.com>
 <20171120180639.GN32488@arm.com>
 <CAKv+Gu8WPU=LKLR90WBpAey2VkCVuuTpQycsde-88G4F_B1wUQ@mail.gmail.com>
Message-ID: <20171122193719.GM22648@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 20, 2017 at 06:20:39PM +0000, Ard Biesheuvel wrote:
> On 20 November 2017 at 18:06, Will Deacon <will.deacon@arm.com> wrote:
> > I'll see if I can measure the cost of the current vbar switching to get
> > an idea of the potential performance available.
> >
> 
> Yeah, makes sense. If the bulk of the performance hit is elsewhere,
> there's no point in focusing on this bit.

I had a go at implementing a variant on your suggestion where we avoid
swizzling the vbar on exception entry/exit but I couldn't reliably measure a
difference in performance. It appears that the ISB needed by the TTBR change
is dominant, so the vbar write is insignificant.

Will
