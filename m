From: will.deacon@arm.com (Will Deacon)
Date: Mon, 1 Jul 2013 10:27:24 +0100
Subject: question about iotable_init( )  function
In-Reply-To: <35FD53F367049845BC99AC72306C23D19441BF586F@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D19441BF586F@CNBJMBX05.corpusers.net>
Message-ID: <20130701092723.GE14027@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 01, 2013 at 08:31:38AM +0100, Wang, Yalin wrote:
> Hi  Will,
> 
> I have a question about iotable_init()  function (arch/arm/mm/mmu.c)
> I found  in this function it only allocate a vm_struct and insert it into vmlist ,
> But it didn?t allocate a vmap_area  to insert it  into vmap_area_root tree (mm/vmalloc.c).
> 
> So this means that the virtual address reserverd by iotable_init is not declared
> In vmap_area_root  ,  this is not safe ,  maybe some driver will use this virtual address as vmalloc again,
> I think it ?s not safe in this condition ,  should also add a vmap_area   node into vmap_area_root to
> Hold this virtual address not used by others .

The vmap_area structures are allocated and inserted later on by vmalloc_init
(iotable init is for static mappings early during boot).

Will
