From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 19 Aug 2015 22:35:26 +0530
Subject: [PATCHv4 6/6] dmaengine: mv_xor: optimize performance by using a
 subset of the XOR channels
In-Reply-To: <1436365699-6862-7-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1436365699-6862-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1436365699-6862-7-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20150819170526.GO13546@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 08, 2015 at 04:28:19PM +0200, Thomas Petazzoni wrote:
> Due to how async_tx behaves internally, having more XOR channels than
> CPUs is actually hurting performance more than it improves it, because
> memcpy requests get scheduled on a different channel than the XOR
> requests, but async_tx will still wait for the completion of the
> memcpy requests before scheduling the XOR requests.
> 
> It is in fact more efficient to have at most one channel per CPU,
> which this patch implements by limiting the number of channels per
> engine, and the number of engines registered depending on the number
> of availables CPUs.
> 
> Marvell platforms are currently available in one CPU, two CPUs and
> four CPUs configurations:
> 
>  - in the configurations with one CPU, only one channel from one
>    engine is used.
> 
>  - in the configurations with two CPUs, only one channel from each
>    engine is used (they are two XOR engines)
> 
>  - in the configurations with four CPUs, both channels of both engines
>    are used.

Applied, thanks

-- 
~Vinod
