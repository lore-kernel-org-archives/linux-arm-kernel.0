From: will.deacon@arm.com (Will Deacon)
Date: Tue, 11 Aug 2015 18:36:01 +0100
Subject: [PATCH v8 0/7] arm64: Add kernel probes (kprobes) support
In-Reply-To: <55CA2AF2.6040202@linaro.org>
References: <1439254364-15362-1-git-send-email-dave.long@linaro.org>
 <20150811165645.GA29880@arm.com> <55CA2AF2.6040202@linaro.org>
Message-ID: <20150811173601.GD29880@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 11, 2015 at 06:03:46PM +0100, David Long wrote:
> On 08/11/15 12:56, Will Deacon wrote:
> > On Tue, Aug 11, 2015 at 01:52:37AM +0100, David Long wrote:
> >> From: "David A. Long" <dave.long@linaro.org>
> >>
> >> This patchset is heavily based on Sandeepa Prabhu's ARM v8 kprobes patches,
> >> first seen in October 2013. This version attempts to address concerns raised by
> >> reviewers and also fixes problems discovered during testing.
> >>
> >> This patchset adds support for kernel probes(kprobes), jump probes(jprobes)
> >> and return probes(kretprobes) support for ARM64.
> >>
> >> The kprobes mechanism makes use of software breakpoint and single stepping
> >> support available in the ARM v8 kernel.
> >>
> >> This patch depends on:
> >> 	[PATCH 1/2] Move the pt_regs_offset struct definition from arch to common include file
> >> 	[PATCH 2/2] Consolidate redundant register/stack access code
> >
> > Are these two queued somewhere? This series doesn't even build without
> > them.
> 
> I posted the last revision of that on July 27.  I don't know if they're 
> "queued" somewhere.  They do affect multiple architectures so I'm not 
> certain where they would get queued. They also live in a branch in my 
> own Linaro repo.

Well they're not in linux-next, so I guess they're not currently destined
for mainline :(

> Was there a better way for me to deal with this dependency?  I was 
> reluctant to make this into one patch set as the other patch really does 
> stand alone as a useful fix.

I agree (well, it's a cleanup not a fix). Perhaps it's worth reposting
them with akpm also on Cc, as he sometimes picks up tree-wide patches
like that.

Will
