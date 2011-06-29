From: dave@linux.vnet.ibm.com (Dave Hansen)
Date: Wed, 29 Jun 2011 10:59:02 -0700
Subject: [PATCH 00/10] mm: Linux VM Infrastructure to support Memory
	Power Management
In-Reply-To: <20110629174220.GA9152@in.ibm.com>
References: <1306499498-14263-1-git-send-email-ankita@in.ibm.com>
	<20110629130038.GA7909@in.ibm.com> <1309367184.11430.594.camel@nimitz>
	<20110629174220.GA9152@in.ibm.com>
Message-ID: <1309370342.11430.604.camel@nimitz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-06-29 at 23:12 +0530, Ankita Garg wrote:
> 	4. The kernel must have a mechanism to maintain utilization
> 	   statistics pertaining to a piece of hardware, so that it can
> 	   trigger the hardware to power it off

Having statistics like this would certainly be nice, but how important
_is_ it?  Is it really a show-stopper?  There's some stuff today, like
the NPT/EPT support in KVM where we don't even have visibility in to
when a given page is referenced.

It's also going to be a pain to track kernel references.  On x86, our
kernel linear mapping uses 1GB pages when it can, and those are greater
than the 512MB granularity that we've been talking about here.  It's
even larger on powerpc.  I'm also pretty sure we don't even _look_ at
the referenced bits in the kernel page tables.  We'll definitely need
some infrastructure to do that.

> 	5. Being able to group these pieces of hardware for purpose of
> 	   higher savings. 

Do you really mean group, or do you mean "turn as many off as possible"?

-- Dave
