From: geoff@infradead.org (Geoff Levand)
Date: Tue, 27 Jan 2015 10:34:57 -0800
Subject: [PATCH 4/8] arm64: Add EL2 switch to soft_restart
In-Reply-To: <20150127164619.GL17721@leverpostej>
References: <cover.1421449714.git.geoff@infradead.org>
 <bb44d4eee4fab15278e4a8829a0981878bc9acd7.1421449714.git.geoff@infradead.org>
 <20150126190223.GO23313@leverpostej>
 <1422308928.21823.16.camel@infradead.org>
 <20150127164619.GL17721@leverpostej>
Message-ID: <1422383697.21823.19.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Tue, 2015-01-27 at 16:46 +0000, Mark Rutland wrote:
> On Mon, Jan 26, 2015 at 09:48:48PM +0000, Geoff Levand wrote:
> > This conditional is just if KVM, do things the old way (don't try to
> > switch exception levels).  It is to handle the system shutdown case.
> 
> Having grepped treewide for soft_restart, other than kexec there are no
> users for arm64. So surely kexec is the only case to cater for at the
> moment?

Yes, I think you're right, and so it seems we can drop this patch and
just have the 'Add checks for KVM' patch.

> > Another patch in this series '[PATCH 7/8] arm64/kexec: Add checks for
> > KVM' assures kexec cannot happen when KVM is configured.
> 
> It would be better to just move this earlier (or event better, implement
> kvm teardown).

Yes, I hope we don't really need to have any KVM work-arounds.

-Geoff
