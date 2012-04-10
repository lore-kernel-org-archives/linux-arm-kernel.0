From: balbi@ti.com (Felipe Balbi)
Date: Tue, 10 Apr 2012 14:41:54 +0300
Subject: [PATCH 00/19] I2C updates
In-Reply-To: <CANfBPZ92EEAqrFC2gnULAXwQKhWdAuNntHz0QVXuUR3Wr=nSGQ@mail.gmail.com>
References: <1334055397-899-1-git-send-email-shubhrajyoti@ti.com>
 <CANfBPZ92EEAqrFC2gnULAXwQKhWdAuNntHz0QVXuUR3Wr=nSGQ@mail.gmail.com>
Message-ID: <20120410114153.GR20616@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2012 at 05:01:37PM +0530, S, Venkatraman wrote:
> On Tue, Apr 10, 2012 at 4:26 PM, Shubhrajyoti D <shubhrajyoti@ti.com> wrote:
> > The patch series does the following
> >
> > - Warn fixes if CONFIG_PM_RUNTIME is not selected.
> > - I2C register restore only if context if the context is lost
> > - Bus busy recovery mechanism.
> > - the reset is not done in init.
> >
> > v2 changes
> > -Adds a patch to use devm_* functions
> > -Also checks the return type of the get_sync and in case
> > ?of errors prevents register access.
> > - In case of i2c remove register access was done without any
> > ?get_sync fix the same.
> > - Adds a pdata function pointer to do context save restore
> >
> > v3 changes
> > - Split the omap_i2c_isr to increase readability
> > - Adds the restore flag patch for OMAP4 to the series
> > - Make the i2c use SET_RUNTIME_PM_OPS
> > v4 changes
> > - Folds a patch from Tasslehoff to prevent any merge conflicts.
> > - Prevents the XDUF flag to be set if the underflow condition is not met.
> >
> > v5 changes
> > - Add consistency in the subject naming.
> >
> > v6 changes
> > - As per discussion in [1] .Adds a patch to rename the 1p153 errata and
> > ?use the unique id instead as the section number in the recent errata
> > ?docs has changed.
> >
> >
> > [1] http://www.spinics.net/lists/linux-i2c/msg07607.html
> >
> > Tested on omap4sdp and omap3sdp.
> >
> >
> > The following changes since commit 258f742635360175564e9470eb060ff4d4b984e7:
> >
> > ?modpost: Fix modpost license checking of vmlinux.o (2012-04-09 20:52:56 -0700)
> >
> > are available in the git repository at:
> > ?git at gitorious.org:linus-tree/linus-tree.git i2c_omap-next
> 
> Minor nit:
> You might want to indicate a git:// link instead of an ssh URL ?

indeed, for those who haven't noticed git now has separate url and
pushurl for every remote. Meaning you can pull and push with different
urls. This solves this issue.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120410/992e23c3/attachment.sig>
