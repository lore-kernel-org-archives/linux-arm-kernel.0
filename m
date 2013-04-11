From: yinghai@kernel.org (Yinghai Lu)
Date: Thu, 11 Apr 2013 08:10:28 -0700
Subject: [PATCH 0/2] mm: vmemmap: add vmemmap_verify check for hot-add
 node/memory case
In-Reply-To: <51666930.6090702@cn.fujitsu.com>
References: <1365415000-10389-1-git-send-email-linfeng@cn.fujitsu.com>
 <CAE9FiQVaByGOTjLVthRkEze_ekXm5LAKgKdHzrD+q1iYmjgZFQ@mail.gmail.com>
 <51666930.6090702@cn.fujitsu.com>
Message-ID: <CAE9FiQU-zqFdSz-7yq5EgV1YCzyNH_BY36Ym3tdHVEHHY6cdNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 12:41 AM, Tang Chen <tangchen@cn.fujitsu.com> wrote:
>
> 3. If we add flag to memblock, we can mark different memory. And I remember
>    you mentioned before that we can use memblock to reserve local node data
>    for node-life-cycle data, like vmemmap, pagetable.
>
>    So are you doing the similar work now ?

No, i did not start it yet.

>
>    If not, I think I can merge it into mine, and push a new patch-set with
>    hot-add, hot-remove code modified to support putting vmemmap, pagetable,
>    pgdat, page_cgroup, ..., on local node.

Need to have it separated with moving_zone.

1. rework memblock to keep alive all the way for hotplug usage.
2. put pagetable and vmemap on the local node range with help of memblock.


Thanks

Yinghai
