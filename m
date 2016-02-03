From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 3 Feb 2016 13:43:32 +0000
Subject: [PATCH] arm64: Allow vmalloc regions to be set with set_memory_*
In-Reply-To: <56AC2462.20506@huawei.com>
References: <CAKv+Gu_A1C9hXgqrYDekoy1YHaRXi_mUF-kYx-TqsOBkWMVjmQ@mail.gmail.com>
 <CAKv+Gu-73QKAsFQCa=yO5+=DihLXp_AKYyY6QRTVM4nuDH=-8g@mail.gmail.com>
 <20160118115640.GK21067@leverpostej> <56A97328.9070003@huawei.com>
 <20160128105138.GE17123@leverpostej> <56A9FFBD.8030303@huawei.com>
 <20160128142746.GL17123@leverpostej> <56AABEA4.3010301@huawei.com>
 <20160129110252.GB17038@leverpostej> <56AC2462.20506@huawei.com>
Message-ID: <20160203134332.GB1234@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 30, 2016 at 10:48:02AM +0800, Xishi Qiu wrote:
 Hi Mark,
> 
> Thanks for your reply. Maybe I didn't express it clearly, sorry for it.
> 
> The abstract process is the following:
> 1. do not create a large block, use 4kb for all of the memory(regardless of performance).
> setup_arch->paging_init()->map_mem()->__map_memblock()->create_mapping()
> 2. alloc a page and get the the linear mapping address.
> 3. modify judgment condition of the function set_memory_ro(), so it could handle the linear mapping range.
> 4. use set_memory_ro() to change the prot flag of the page which we get in step 2.
> 
> Is it safe?

This will be free from the problems associated with splitting/fusing
sections.

My concern was with what exactly this "special memory" was and how it
was being used. It sounds like either some infrstructure is missing, or
you are using the wrong abstractions.

Thanks,
Mark.
