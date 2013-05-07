From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Tue, 7 May 2013 14:08:57 -0700
Subject: [PATCH] clk: Always notify whole subtree when reparenting
In-Reply-To: <20130507205953.4542.62609@quantum>
References: <afe397e3-c674-4dc3-9f3e-feea9275bb91@TX2EHSMHS023.ehs.local>
 <20130507205953.4542.62609@quantum>
Message-ID: <4ee1b52e-8c1d-4161-9034-62fc6c48fd12@CO9EHSMHS026.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 07, 2013 at 01:59:53PM -0700, Mike Turquette wrote:
> Quoting Soren Brinkmann (2013-04-16 10:06:50)
> > A clock's notifier count only reflects notifiers which are registered
> > directly for that clock. A reparent operation though affects the whole
> > subtree because of a potential rate change.
> > When issuing the pre rate change notifications only the notifier count
> > for the clock to be changed is considered and notifiers for subclocks
> > may never be called. Resulting in clocks in the subtree which have
> > registered notifiers, may receive a POST_- or ABORT_RATE_CHANGE
> > notification, without a PRE_RATE_CHANGE_NOTIFICATION.
> > Therefore always traverse the whole subtree when issueing pre rate
> > change notifications during a reparent operation.
> > 
> > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > ---
> > This should probably be considered an RFC. There may be smarter ways to
> > resolve this issue. E.g. forward notifier counts upstream the way it is done
> > with enable counts.
> > 
> 
> I've taken this patch for 3.11.
thank you.

	S?ren
