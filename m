From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 31 Jan 2011 11:22:50 -0500 (EST)
Subject: [linux-pm] [PATCH] i2c: OMAP: fix static suspend vs. runtime
	suspend
In-Reply-To: <877hdl9hsn.fsf@ti.com>
Message-ID: <Pine.LNX.4.44L0.1101311119190.1931-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 31 Jan 2011, Kevin Hilman wrote:

> I understand how this works, but frankly I'm still a bit fuzzy on why.
> 
> I guess I'm still missing a good understanding of what "interfering with a
> system power transition" means, and why a runtime suspend qualifies as
> interfering but not a runtime resume.

These are good questions.  Rafael implemented this design originally; 
my contribution was only to warn him of the potential for problems.  
Therefore he should explain the rationale for the design.

> More specifically, the reason for $SUBJECT patch is precisely because a
> runtime resume is allowed, a runtime suspend is not, and thus a system
> power transititon is prevented.

Alan Stern
