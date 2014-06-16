From: iamjoonsoo.kim@lge.com (Joonsoo Kim)
Date: Mon, 16 Jun 2014 14:32:09 +0900
Subject: [PATCH v2 00/10] CMA: generalize CMA reserved area management code
In-Reply-To: <87r42seyvg.fsf@linux.vnet.ibm.com>
References: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <87r42seyvg.fsf@linux.vnet.ibm.com>
Message-ID: <20140616053209.GG23210@js1304-P5Q-DELUXE>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 14, 2014 at 12:55:39PM +0530, Aneesh Kumar K.V wrote:
> Joonsoo Kim <iamjoonsoo.kim@lge.com> writes:
> 
> > Currently, there are two users on CMA functionality, one is the DMA
> > subsystem and the other is the kvm on powerpc. They have their own code
> > to manage CMA reserved area even if they looks really similar.
> > From my guess, it is caused by some needs on bitmap management. Kvm side
> > wants to maintain bitmap not for 1 page, but for more size. Eventually it
> > use bitmap where one bit represents 64 pages.
> >
> > When I implement CMA related patches, I should change those two places
> > to apply my change and it seem to be painful to me. I want to change
> > this situation and reduce future code management overhead through
> > this patch.
> >
> > This change could also help developer who want to use CMA in their
> > new feature development, since they can use CMA easily without
> > copying & pasting this reserved area management code.
> >
> > v2:
> >   Although this patchset looks very different with v1, the end result,
> >   that is, mm/cma.c is same with v1's one. So I carry Ack to patch 6-7.
> >
> > Patch 1-5 prepare some features to cover ppc kvm's requirements.
> > Patch 6-7 generalize CMA reserved area management code and change users
> > to use it.
> > Patch 8-10 clean-up minor things.
> 
> 
> I wanted to test the ppc changes and found that the patch series doesn't apply
> against v3.15 . Do you have a kernel tree which I can clone to test this
> series ?

This is based on linux-next -next-20140610.
And my tree is on following link.

https://github.com/JoonsooKim/linux/tree/cma-general-v2.0-next-20140610

But, I think I'm late, because you have already added a Tested-by tag.

Thanks.
