From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 9 Jan 2014 10:35:05 -0700
Subject: [RFC PATCH 3/9] of: mtd: add NAND timings retrieval support
In-Reply-To: <52CE5F82.6070802@overkiz.com>
References: <1389190924-26226-1-git-send-email-b.brezillon@overkiz.com>
 <1389190924-26226-4-git-send-email-b.brezillon@overkiz.com>
 <20140108183418.GA12358@obsidianresearch.com>
 <52CDA032.3010804@overkiz.com>
 <20140108191339.GB12358@obsidianresearch.com>
 <52CE5F82.6070802@overkiz.com>
Message-ID: <20140109173505.GB8899@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 09, 2014 at 09:36:18AM +0100, boris brezillon wrote:

> >You might want to check if you can boil down the DT timings from the
> >huge list to just an ONFI mode number..
> 
> Sure, but the sunxi driver needs at least 19 of them...

So does mvebu's NAND driver..

What I ment was you could have a

  onfi,nand-timing-mode = 0

in the DT. Each of the modes defines all ~19 parameters, higher modes
are faster.

Pick a mode value that fits all the parameters of the connected
non-ONFI flash.

This would be instead of defining each parameter
individually.. Provide some helpers to convert from a onfi mode number
to all the onfi defined timing parameters so that drivers can
configure the HW..

Jason
