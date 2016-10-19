From: lstoakes@gmail.com (Lorenzo Stoakes)
Date: Wed, 19 Oct 2016 10:06:46 +0100
Subject: [PATCH 08/10] mm: replace __access_remote_vm() write parameter
 with gup_flags
In-Reply-To: <20161019085204.GD7517@dhcp22.suse.cz>
References: <20161013002020.3062-1-lstoakes@gmail.com>
 <20161013002020.3062-9-lstoakes@gmail.com>
 <20161019075903.GP29967@quack2.suse.cz>
 <20161019081352.GB7562@dhcp22.suse.cz>
 <20161019084045.GA19441@lucifer>
 <20161019085204.GD7517@dhcp22.suse.cz>
Message-ID: <20161019090646.GA24243@lucifer>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2016 at 10:52:05AM +0200, Michal Hocko wrote:
> yes this is the desirable and expected behavior.
>
> > wonder if this is desirable behaviour or whether this ought to be limited to
> > ptrace system calls. Regardless, by making the flag more visible it makes it
> > easier to see that this is happening.
>
> mem_open already enforces PTRACE_MODE_ATTACH

Ah I missed this, that makes a lot of sense, thanks!

I still wonder whether other invocations of access_remote_vm() in fs/proc/base.c
(the principle caller of this function) need FOLL_FORCE, for example the various
calls that simply read data from other processes, so I think the point stands
about keeping this explicit.
