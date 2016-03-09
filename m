From: robert.richter@caviumnetworks.com (Robert Richter)
Date: Wed, 9 Mar 2016 12:36:38 +0100
Subject: [PATCH v2 1/2] arm64: vmemmap: use virtual projection of linear
 region
In-Reply-To: <20160309113214.GB1535@rric.localdomain>
References: <1456505834-8638-1-git-send-email-ard.biesheuvel@linaro.org>
 <1456505834-8638-2-git-send-email-ard.biesheuvel@linaro.org>
 <56DE25DD.4010401@gmail.com>
 <E540D948-6371-4F71-A8B6-025BC39A0515@linaro.org>
 <CAKv+Gu9mwj0qscQJSH8wEi0zYC0anrr1hBYbdFE83iN+oQLnRQ@mail.gmail.com>
 <20160309113214.GB1535@rric.localdomain>
Message-ID: <20160309113638.GC1535@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09.03.16 12:32:14, Robert Richter wrote:
> On 08.03.16 17:31:05, Ard Biesheuvel wrote:
> > On 8 March 2016 at 09:15, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> > I managed to reproduce and diagnose this. The problem is that vmemmap
> > is no longer zone aligned, which causes trouble in the zone based
> > rounding that occurs in memory_present. The below patch fixes this by
> > rounding down the subtracted offset. Since this implies that the
> > region could stick off the other end, it also reverts the halving of
> > the region size.
> 
> I have seen the same panic. The fix solves the problem. See enclosed
> diff for reference as there was some patch corruption of the original.

So this is:

Tested-by: Robert Richter <rrichter@cavium.com>

-Robert
