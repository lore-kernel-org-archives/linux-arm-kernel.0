From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Jan 2013 11:04:38 +0000
Subject: [PATCH v2 1/1] block: blk-merge: don't merge the pages with
 non-contiguous descriptors
In-Reply-To: <1358420507.2394.19.camel@dabdike.int.hansenpartnership.com>
References: <1358265681-25671-1-git-send-email-subhashj@codeaurora.org>
 <1358266794.10591.8.camel@dabdike.int.hansenpartnership.com>
 <50F64AC1.3040304@codeaurora.org>
 <1358332355.2384.11.camel@dabdike.int.hansenpartnership.com>
 <20130116231857.GU2668@htj.dyndns.org>
 <1358413880.2394.7.camel@dabdike.int.hansenpartnership.com>
 <20130117103742.GX23505@n2100.arm.linux.org.uk>
 <20130117104741.GY23505@n2100.arm.linux.org.uk>
 <1358420507.2394.19.camel@dabdike.int.hansenpartnership.com>
Message-ID: <20130117110438.GZ23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 17, 2013 at 11:01:47AM +0000, James Bottomley wrote:
> On Thu, 2013-01-17 at 10:47 +0000, Russell King - ARM Linux wrote:
> > Also, couldn't the addition of the scatterlist offset to the page also
> > be buggy too?
> 
> No, fortunately, offset must be within the first page from the point of
> view of block generated sg lists.  As long as nothing within arm
> violates this, it should be a safe assumption ... although the code
> seems to assume otherwise.

Are you absolutely sure about that?  I believe I have seen cases where
that has been violated in the past, though it was many years ago.
