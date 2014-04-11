From: oleg@redhat.com (Oleg Nesterov)
Date: Fri, 11 Apr 2014 20:36:19 +0200
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <CAA3XUr0e71yOX0NurYBog8SxcDVPZ00Xr4SGqNOS4GKMFoYGiQ@mail.gmail.com>
References: <20140411153041.GQ16119@n2100.arm.linux.org.uk>
 <20140411172456.GA20506@redhat.com>
 <CA+55aFx=1O67Wi85g_3qiUzxyxfFU0RZQMkMj4_kOB=2T09jwQ@mail.gmail.com>
 <20140411.140213.521479030434404328.davem@davemloft.net>
 <CAA3XUr0e71yOX0NurYBog8SxcDVPZ00Xr4SGqNOS4GKMFoYGiQ@mail.gmail.com>
Message-ID: <20140411183619.GB23105@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11, Victor Kamensky wrote:
>
> On 11 April 2014 11:02, David Miller <davem@davemloft.net> wrote:
> But in uprobes case xol slot where instruction write happened will be
> used only by current CPU. The way I read uprobes code other core
> when it hit the same uprobe address will use different xol slot. Xol slot
> size is cache line so it will not be moved around.

Yes.

> So as long as we
> know for sure that while tasks performs single step on uprobe xol
> area instruction it won't be migrated to another core we don't need to
> do broadcast to any other cores.

It can migrate to another CPU before it does single-step.

Oleg.
