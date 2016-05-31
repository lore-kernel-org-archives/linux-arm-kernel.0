From: will.deacon@arm.com (Will Deacon)
Date: Tue, 31 May 2016 14:15:20 +0100
Subject: [BUG] Page allocation failures with newest kernels
In-Reply-To: <60e8df74202e40b28a4d53dbc7fd0b22@IL-EXCH02.marvell.com>
References: <CAPv3WKcVsWBgHHC3UPNcbka2JUmN4CTw1Ym4BR1=1V9=B9av5Q@mail.gmail.com>
 <574D64A0.2070207@arm.com>
 <CAPv3WKdYdwpi3k5eY86qibfprMFwkYOkDwHOsNydp=0sTV3mgg@mail.gmail.com>
 <60e8df74202e40b28a4d53dbc7fd0b22@IL-EXCH02.marvell.com>
Message-ID: <20160531131520.GI24936@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2016 at 01:10:44PM +0000, Yehuda Yitschak wrote:
> During some of the stress tests we also came across a different warning
> from the arm64  page management code
> It looks like a race is detected between HW and SW marking a bit in the PTE

A72 (which I believe is the CPU in that SoC) is a v8.0 CPU and therefore
doesn't have hardware DBM.

> Not sure it's really related but I thought it might give a clue on the issue
> http://pastebin.com/ASv19vZP

There have been a few patches from Catalin to fix up the hardware DBM
patches, so it might be worth trying to reproduce this failure with a
more recent kernel. I doubt this is related to the allocation failures,
however.

Will
