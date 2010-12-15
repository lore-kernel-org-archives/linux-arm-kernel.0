From: davidb@codeaurora.org (David Brown)
Date: Wed, 15 Dec 2010 05:44:14 -0800
Subject: [PATCH v5 5/5] msm: add SMP support for msm
In-Reply-To: <AANLkTimnuTcv+5cWNzvV-Z=1LHsAmTojDSBJMjjOs7K+@mail.gmail.com>
References: <1292302233-16194-1-git-send-email-johlstei@codeaurora.org>
	<1292302233-16194-6-git-send-email-johlstei@codeaurora.org>
	<AANLkTimnuTcv+5cWNzvV-Z=1LHsAmTojDSBJMjjOs7K+@mail.gmail.com>
Message-ID: <20101215134414.GA8682@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 15, 2010 at 12:35:18PM +0000, Catalin Marinas wrote:
> On 14 December 2010 04:50, Jeff Ohlstein <johlstei@codeaurora.org> wrote:
> > + ? ? ? outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
> > + ? ? ? __asm__("sev");
> > + ? ? ? dsb();
> 
> What's the need for the dsb() here (one before SEV maybe)?
> 
> Also, do we need to add a "memory" clobber to the SEV asm, not sure
> whether the compiler would try to reorder the code.

It doesn't seem to, but it seems to me that it would be allowed to,
so, I would think the "memory" clobber should be there.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
