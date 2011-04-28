From: pwaechtler@mac.com (Peter Waechtler)
Date: Thu, 28 Apr 2011 22:26:22 +0200
Subject: since when does ARM map the kernel memory in sections?
Message-ID: <201104282226.23005.pwaechtler@mac.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 27. April 2011, 02:27:57 schrieben Sie:
> On Tue, Apr 26, 2011 at 5:58 PM, Jamie Lokier <jamie@shareable.org> wrote:
> >> Reliable writes are exposed via REQ_FUA.
> > 
> > Are you sure that's appropriate?
> > 
> > Unless I have misunderstood (very possible), REQ_FUA means writes hit
> > non-volatile storage before acknowledgement, not that they are atomic.
> > I think the normal users of REQ_FUA don't require or expect large
> > atomic writes; they use it as a shortcut for (write & flush this
> > write) without implying anything else is flushed.
> 
> I would agree with you that it's not the best mapping. However, a failed
> MMC write transaction has other properties. If I understand correctly,
> depending on mode of failure (say pulling power), you might wind up
> with extra data getting erased (because erase
> happens at erase unit boundary), and erase can be done before all the
> data was transferred from host to card.
> 

No, it's not because of the erase unit size larger than write size.
An "erase unit" is cleared by garbage collection only IFF the complete unit is 
unused - asynchronously by the ongoing write transaction. The problem with 
damaging neighboring data is: density. No beer (today), i'm drinking wine ;)

The cells storing the "bits" gets smaller and smaller and with multi level 
cells even more bits are represented by "fewer electrons". Programming the 
neighbor cell disturbs the fragile cells. If the error correction is disturbed 
by power loss: off we go... 

Someone from the flash vendors eavesdropping? Please, pretty please ... :)

	Peter

P.S. Andrei: sorry for reposting, but Kmail confuses me with "Reply to all"
