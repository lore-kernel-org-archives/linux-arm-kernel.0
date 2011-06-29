From: andi@firstfloor.org (Andi Kleen)
Date: Wed, 29 Jun 2011 13:11:00 -0700
Subject: [PATCH 00/10] mm: Linux VM Infrastructure to support Memory Power
	Management
In-Reply-To: <1309370342.11430.604.camel@nimitz> (Dave Hansen's message of
	"Wed, 29 Jun 2011 10:59:02 -0700")
References: <1306499498-14263-1-git-send-email-ankita@in.ibm.com>
	<20110629130038.GA7909@in.ibm.com> <1309367184.11430.594.camel@nimitz>
	<20110629174220.GA9152@in.ibm.com> <1309370342.11430.604.camel@nimitz>
Message-ID: <m2y60k1jqj.fsf@firstfloor.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dave Hansen <dave@linux.vnet.ibm.com> writes:
>
> It's also going to be a pain to track kernel references.  On x86, our

Even if you tracked them what would you do with them?

It's quite hard to stop using arbitary kernel memory (see all the dancing
memory-failure does) 

You need to track the direct accesses to user data which happens
to be accessed through the direct mapping.

Also it will be always unreliable because this all won't track DMA.
For that you would also need to track in the dma_* infrastructure,
which will likely get seriously expensive.

-Andi

-- 
ak at linux.intel.com -- Speaking for myself only
