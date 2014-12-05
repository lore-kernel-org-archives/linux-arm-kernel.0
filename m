From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 5 Dec 2014 20:40:14 +0530
Subject: [PATCH] dmaengine: pl330: Set residue in tx_status callback
In-Reply-To: <547DF61D.3010909@metafoo.de>
References: <1416995095-13763-1-git-send-email-padma.v@samsung.com>
 <CAAgF-BfpU72KTJjVd8jWStD8yJ5sSmXOiQm77xQunO2QhC9ExQ@mail.gmail.com>
 <547DF61D.3010909@metafoo.de>
Message-ID: <20141205151014.GK3411@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 02, 2014 at 06:25:49PM +0100, Lars-Peter Clausen wrote:
> On 12/02/2014 06:38 AM, Padma Venkat wrote:
> 
> Well it doesn't break audio, but I don't think it has the correct
> haviour for all cases yet.
> 
> Again, the semantics are that it should return the progress of the
> transfer for which the allocation function returned the cookie that
> is passe to this function. You have to consider that there might be
> multiple different descriptors submitted and in the work list, not
> just the one we want to know the status of. The big problem with the
> pl330 driver is that the current structure of the driver makes it
> not so easy to implement the residue reporting correctly.

well you can use the completed_cookie as hint. This was last trasaction
which was issues, so calculate remianing bytes for this and subsequent ones
resiude would only be size of transaction

-- 
~Vinod
