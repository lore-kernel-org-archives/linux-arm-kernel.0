From: tangchen@cn.fujitsu.com (Tang Chen)
Date: Thu, 11 Apr 2013 15:41:36 +0800
Subject: [PATCH 0/2] mm: vmemmap: add vmemmap_verify check for hot-add
 node/memory case
In-Reply-To: <CAE9FiQVaByGOTjLVthRkEze_ekXm5LAKgKdHzrD+q1iYmjgZFQ@mail.gmail.com>
References: <1365415000-10389-1-git-send-email-linfeng@cn.fujitsu.com>
 <CAE9FiQVaByGOTjLVthRkEze_ekXm5LAKgKdHzrD+q1iYmjgZFQ@mail.gmail.com>
Message-ID: <51666930.6090702@cn.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yinghai,

(Add cc Liu Jiang.)

On 04/09/2013 02:40 AM, Yinghai Lu wrote:
> On Mon, Apr 8, 2013 at 2:56 AM, Lin Feng<linfeng@cn.fujitsu.com>  wrote:
>> In hot add node(memory) case, vmemmap pages are always allocated from other
>> node,
>
> that is broken, and should be fixed.
> vmemmap should be on local node even for hot add node.
>

I want some info sharing. :)

Here is the work I'm trying to do.

1. As most of people don't like movablemem_map idea, we decide to
    drop "specifying physical address" thing, and restart a new solution
    to support using SRAT info only.

    We want to modify movablecore to support "movablecore=acpi" to
    enable/disable limiting hotpluggable memory in ZONE_MOVABLE.
    And we dropped all the old design and data structures.

2. As Liu Jiang mentioned before, we can add a flag to memblock to mark
    special memory. Since we are dropping all the old data structures,
    I think I want to reuse his idea to reserve movable memory with memblock
    when booting.

3. If we add flag to memblock, we can mark different memory. And I remember
    you mentioned before that we can use memblock to reserve local node 
data
    for node-life-cycle data, like vmemmap, pagetable.

    So are you doing the similar work now ?

    If not, I think I can merge it into mine, and push a new patch-set with
    hot-add, hot-remove code modified to support putting vmemmap, 
pagetable,
    pgdat, page_cgroup, ..., on local node.

    If you are doing the similar work, I will only finish my work and wait
    for your patch.

Thanks. :)
