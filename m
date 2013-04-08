From: akpm@linux-foundation.org (Andrew Morton)
Date: Mon, 8 Apr 2013 13:55:53 -0700
Subject: [PATCH 0/2] mm: vmemmap: add vmemmap_verify check for hot-add
 node/memory case
In-Reply-To: <CAE9FiQVaByGOTjLVthRkEze_ekXm5LAKgKdHzrD+q1iYmjgZFQ@mail.gmail.com>
References: <1365415000-10389-1-git-send-email-linfeng@cn.fujitsu.com>
 <CAE9FiQVaByGOTjLVthRkEze_ekXm5LAKgKdHzrD+q1iYmjgZFQ@mail.gmail.com>
Message-ID: <20130408135553.2f60518d923b6920bdf1931f@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 8 Apr 2013 11:40:11 -0700 Yinghai Lu <yinghai@kernel.org> wrote:

> On Mon, Apr 8, 2013 at 2:56 AM, Lin Feng <linfeng@cn.fujitsu.com> wrote:
> > In hot add node(memory) case, vmemmap pages are always allocated from other
> > node,
> 
> that is broken, and should be fixed.
> vmemmap should be on local node even for hot add node.
> 

That would be nice.

I don't see much value in the added warnings, really.  Because there's
nothing the user can *do* about them, apart from a) stop using NUMA, b)
stop using memory hotplug, c) become a kernel MM developer or d) switch
to Windows.
