From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 24 Oct 2013 22:08:29 +0530
Subject: [PATCH 2/3] dma: edma: Add support for Cyclic DMA
In-Reply-To: <52669A23.2080805@ti.com>
References: <1379977515-3794-1-git-send-email-joelf@ti.com>
 <1379977515-3794-3-git-send-email-joelf@ti.com>
 <20131021065319.GM14013@intel.com> <52669A23.2080805@ti.com>
Message-ID: <20131024163829.GA21230@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 22, 2013 at 10:30:43AM -0500, Joel Fernandes wrote:
> On 10/21/2013 01:53 AM, Vinod Koul wrote:
> > On Mon, Sep 23, 2013 at 06:05:14PM -0500, Joel Fernandes wrote:
> >> +	nr_periods = (buf_len / period_len) + 1;
> > ?
> > 
> > consider the case of buf = period_len, above makes nr_period = 2.
> > 
> > Or buf len 100, period len 50, makes nr_period = 3
> > 
> > Both doesnt seem right to me?
> 
> I guess that variable name is misleading.
> 
> nr_periods is actually the total no.of slots needed to process the request. Its
> value is 1 greater than the total number of periods.
Okay sounds good to me. I tried applying below but looks like it fails as I have
already applied, 1 & 3. Can you pls rebase this resend

--
~Vinod
