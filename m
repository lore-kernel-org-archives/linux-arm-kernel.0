From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 22 Jan 2013 15:54:21 -0500
Subject: [PATCH v5 01/45] percpu_rwlock: Introduce the global
 reader-writer lock backend
In-Reply-To: <50FEEF5D.6080302@linux.vnet.ibm.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122073315.13822.27093.stgit@srivatsabhat.in.ibm.com>
 <1358883152.21576.55.camel@gandalf.local.home>
 <50FEEF5D.6080302@linux.vnet.ibm.com>
Message-ID: <1358888061.21576.57.camel@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-01-23 at 01:28 +0530, Srivatsa S. Bhat wrote:

> > I thought global locks are now fair. That is, a reader will block if a
> > writer is waiting. Hence, the above should deadlock on the current
> > rwlock_t types.
> > 
> 
> Oh is it? Last I checked, lockdep didn't complain about this ABBA scenario!

It doesn't and Peter Zijlstra said we need to fix that ;-)  It only
recently became an issue with the new "fair" locking of rwlocks.

-- Steve
