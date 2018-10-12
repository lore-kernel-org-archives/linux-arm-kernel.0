From: jannh@google.com (Jann Horn)
Date: Fri, 12 Oct 2018 20:23:15 +0200
Subject: [PATCH v2 1/7] modules: Create rlimit for module space
In-Reply-To: <CAG48ez2fWg64nGxDXUQS3695KpVNrakAbarXJnYPd6xv5wOD+A@mail.gmail.com>
References: <20181011233117.7883-1-rick.p.edgecombe@intel.com>
 <20181011233117.7883-2-rick.p.edgecombe@intel.com>
 <CAG48ez2fWg64nGxDXUQS3695KpVNrakAbarXJnYPd6xv5wOD+A@mail.gmail.com>
Message-ID: <CAG48ez0pPX7XNqSj4dVG1s+PaDBCh4ar5xw1WcY1sLBPV_QAzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 12, 2018 at 2:35 AM Jann Horn <jannh@google.com> wrote:
> On Fri, Oct 12, 2018 at 1:40 AM Rick Edgecombe
> <rick.p.edgecombe@intel.com> wrote:
> > This introduces a new rlimit, RLIMIT_MODSPACE, which limits the amount of
> > module space a user can use. The intention is to be able to limit module space
> > allocations that may come from un-privlidged users inserting e/BPF filters.
>
> Note that in some configurations (iirc e.g. the default Ubuntu
> config), normal users can use the subuid mechanism (the /etc/subuid
> config file and the /usr/bin/newuidmap setuid helper) to gain access
> to 65536 UIDs, which means that in such a configuration,
> RLIMIT_MODSPACE*65537 is the actual limit for one user. (Same thing
> applies to RLIMIT_MEMLOCK.)

Actually, I may have misremembered, perhaps it's not installed by
default - I just checked in a Ubuntu VM, and the newuidmap helper from
the uidmap package wasn't installed.
