From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 25 May 2015 22:22:57 +0530
Subject: [PATCH v3 6/6] Documentation: dmaengine: document DMA_CTRL_ACK
In-Reply-To: <87twvekij8.fsf@belgarion.home>
References: <1431626006-1708-1-git-send-email-robert.jarzmik@free.fr>
 <1431626006-1708-6-git-send-email-robert.jarzmik@free.fr>
 <20150514183853.GN4004@lukather> <87twvekij8.fsf@belgarion.home>
Message-ID: <20150525165257.GI3140@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 14, 2015 at 10:31:39PM +0200, Robert Jarzmik wrote:
> Maxime Ripard <maxime.ripard@free-electrons.com> writes:
> 
> > Hi Robert,
> >
> >>    * DMA_CTRL_ACK
> >> -    - Undocumented feature
> >> -    - No one really has an idea of what it's about, besides being
> >> -      related to reusing the DMA transaction descriptors or having
> >> -      additional transactions added to it in the async-tx API
> >> -    - Useless in the case of the slave API
> >> +    - if set, the TX transfer can be reused after being completed.
> >
> > Your sentences should start with an upper-case letter.
> Ack.
> 
> >> +    - there is a guarantee the TX won't be freed until it is acked
> >> +      by async_tx_ack()
> >
> > We never talked about what a "TX transfer" is in the
> > documentation. That should be documented.
> I'll remove the "TX", the transfer is widely used in this documentation.
> 
> >
> >> +    - as a consequence, if a device driver wants to skip the dma_map_sg() and
> >> +      dma_unmap_sg() because the DMA'd data wasn't used, it can resubmit the
> >> +      transfer right after its completion.
> >
> > From a provider PoV, the data should always be mapped and / or
> > allocated in coherent way, so I'm not sure how does that's relevant in
> > the provider doc.
> It's relevant because it says the mapping/unmapping is not necessary _between_ 2
> submission of a transfer. This implies it is mapped, as it is a requirement for
> the very first submission.
> 
> > Also, we should still mention that it's !slave API only.
> Certainly not, it's fully slave API, that's the purpose of this patch.
Its is not dependent on slave, it cna be used by slave as well as other
users

-- 
~Vinod
