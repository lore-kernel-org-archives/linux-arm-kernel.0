From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 17 Mar 2015 16:20:31 +0000
Subject: [RFC PATCH 0/3] arm64: relocatable kernel proof of concept
In-Reply-To: <AEDF43E0-1C4F-43DF-B8A2-BFF7836091E8@linaro.org>
References: <1426519423-28263-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150316160948.GB18277@leverpostej>
 <CAKv+Gu_-1XMcpobRt7tXCZaqWoszWLfJxgHBLaKuWchz87UnSA@mail.gmail.com>
 <20150316173324.GA21040@leverpostej>
 <AEDF43E0-1C4F-43DF-B8A2-BFF7836091E8@linaro.org>
Message-ID: <20150317162030.GL23340@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Hmm. I'd be rather worried about the fixup step; I suspect that'll be
> > fragile and rarely tested. Perhaps we could verify them at boot time?
> 
> It would essentially be __relocate_kernel() but executed at build time against vmlinux with a reloc offset of #0

Sure, the logic is simple enough.

What I'm worried about is something changing in the build system
somewhere and we accidentally miss the fixup somehow in some cases,
we accidentally apply the fixup to the wrong field, or things like that.

At that stage there's very little sanity checking that we can do a la
BUILD_BUG_ON, ASSERT, etc.

Which isn't to say that we can't do that, just that I feel a little
uneasy about it.

Mark.
