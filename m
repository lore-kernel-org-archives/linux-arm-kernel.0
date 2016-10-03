From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 3 Oct 2016 09:09:24 +0530
Subject: [PATCH V4 05/10] dmaengine: qcom_hidma: make pending_tre_count
 atomic
In-Reply-To: <e5782331-0dc6-9e0e-777c-372dc88f38e3@codeaurora.org>
References: <1475115167-5898-1-git-send-email-okaya@codeaurora.org>
 <1475115167-5898-6-git-send-email-okaya@codeaurora.org>
 <20161001061906.GG2467@localhost>
 <e5782331-0dc6-9e0e-777c-372dc88f38e3@codeaurora.org>
Message-ID: <20161003033923.GQ2467@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 01, 2016 at 11:19:43AM -0400, Sinan Kaya wrote:
> On 10/1/2016 2:19 AM, Vinod Koul wrote:
> >> Making it atomic so that it can be updated from multiple contexts.
> > How is it multiple contexts? It's either existing context of MSI, not both!
> > 
> 
> I was trying to mean multiple processor contexts here. The driver allocates 11
> MSI interrupts. Each MSI interrupt can be assigned to a different CPU. Then, 
> we have a race condition for common variables as they share the same interrupt
> handler with a different cause bit. 
> 
> I will put the above description into the commit text.

Sounds better :)

-- 
~Vinod
