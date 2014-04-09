From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 9 Apr 2014 10:30:54 -0600
Subject: [PATCH v2] bus: mvebu-mbus: Avoid setting an undefined window size
In-Reply-To: <20140409095350.47029549@skate>
References: <1397000654-10849-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <20140409061128.GC16465@1wt.eu> <20140409091234.20f2e547@skate>
 <20140409074752.GF16465@1wt.eu> <20140409095350.47029549@skate>
Message-ID: <20140409163054.GA30642@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 09, 2014 at 09:53:50AM +0200, Thomas Petazzoni wrote:

> Maybe this is something that Jason can confirm/infirm. I remember
> having a quick look at the core Linux PCI core to see if it was
> somehow checking whether the bridge BAR has been properly configured,
> but I think I concluded it was not the case, and it was just assuming
> that write the memory base/limit in the bridge registers was
> sufficient. 

I think the best way to fail would be to return an error from
mvebu_pcie_align_resource - but we can't create the window in that
call.

Once things get to the BAR write stage it shouldn't fail unfortunately.

Jason
