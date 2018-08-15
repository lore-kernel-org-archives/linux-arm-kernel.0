From: duwe@lst.de (Torsten Duwe)
Date: Wed, 15 Aug 2018 15:47:10 +0200
Subject: [PATCH 1/3] arm64: implement ftrace with regs
In-Reply-To: <20180814120433.1f5e8da1@gandalf.local.home>
References: <20180810160043.9E45568C76@newverein.lst.de>
 <20180810160223.D360D68C76@newverein.lst.de>
 <2b5c1092-2cc0-00ec-ba3d-341dc61452b4@arm.com>
 <20180813220315.6e8dfc9c@vmware.local.home>
 <a19d9e23-3dfa-ba9b-a177-cdc0d1035964@arm.com>
 <20180814120433.1f5e8da1@gandalf.local.home>
Message-ID: <20180815134710.GA27854@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[working on V2 with your feedback]

On Tue, Aug 14, 2018 at 12:04:33PM -0400, Steven Rostedt wrote:
> On Tue, 14 Aug 2018 09:33:52 +0100
> Julien Thierry <julien.thierry@arm.com> wrote:
> > >> Shouldn't this be an error? The option -fpatchable-function-entry has
> > >> been added to the CC_FLAGS_FTRACE, so any call to the compiler is gonna
> > >> break anyway. Or am I missing something?  

This should be the case.

> OK, I see what you mean. If the resulting build wont boot, then yes
> this should be an error and not a warning.

No, there won't be a binary because the first gcc invocation with
CC_FLAGS_FTRACE will error out.

The alternatives are a makefile-warning followed by a gcc-error or just
a makefile-error. The makefile warning or error should hint at the causing
config option, that's the key point. Beyond that I don't have any preference.

	Torsten
