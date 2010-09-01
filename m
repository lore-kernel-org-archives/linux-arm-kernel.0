From: Simon.Richter@hogyros.de (Simon Richter)
Date: Wed, 1 Sep 2010 10:01:52 +0200
Subject: ptrace(PTRACE_PEEKUSER, ..., PT_TEXT_ADDR, ...)
In-Reply-To: <20100901071701.GC8142@n2100.arm.linux.org.uk>
References: <20100820124118.GC6950@richter>
	<20100901071701.GC8142@n2100.arm.linux.org.uk>
Message-ID: <20100901080152.GA3474@richter>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Sep 01, 2010 at 08:17:01AM +0100, Russell King - ARM Linux wrote:

> > As has been pointed out by Andreas Schwab from SuSE, the code
> > responsible for returning the text segment address is never reached
> > because the lines immediately before the code added in the commit
> > already filter these out and return -EIO.

> I've always regarded this PT_* stuff as a hack around the problem at
> hand - and as you point out below...

Well, in principle the user page would be the right place for them, and
the PT_* defines allow accessing the struct members without requiring
"offsetof" or similar compiler extensions.

> ... it has the potential to break horribly when the original API is
> extended through additional hardware features.

Only as long as there are no struct members defined that will be carried
over to future versions. I have no real idea why the ARM port has this
hack.

> Maybe this is something which should be fixed properly by introducing
> a proper cross-arch API for getting this information.

The other architectures have added a proper member to struct user.

   Simon
