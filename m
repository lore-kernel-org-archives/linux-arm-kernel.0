From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 18 Apr 2016 10:04:16 +0100
Subject: [PATCH] arm64: dts: uniphier: add /memreserve/ for spin-table
 release address
In-Reply-To: <CAK7LNATtWyZtVWrW3nOYjN=aRvCO1w8Rvr6_JWm3QfMMPhrSAQ@mail.gmail.com>
References: <1460743138-17768-1-git-send-email-yamada.masahiro@socionext.com>
 <20160418084508.GA21438@leverpostej>
 <CAK7LNATtWyZtVWrW3nOYjN=aRvCO1w8Rvr6_JWm3QfMMPhrSAQ@mail.gmail.com>
Message-ID: <20160418090415.GB21438@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2016 at 05:55:14PM +0900, Masahiro Yamada wrote:
> 2016-04-18 17:45 GMT+09:00 Mark Rutland <mark.rutland@arm.com>:
> > I take it that the code for the spin-table is not in RAM, and does not
> > need to be protected similarly?
> 
> I use U-Boot to boot Linux for this board.
> 
> The code for the spin-table is on SDRAM, and not protected.
> 
> I already recognize this problem.
> 
> The difficulty for U-Boot is that
> U-Boot relocates itself to the top of the DRAM.
> So, it is difficult to predict
> where the code will be placed.
> 
> I will discuss this issue in the U-Boot ML.

Ok, please do.

> So, My current solution is pre-fetch the code for the spin-table onto
> I-cache.

As you are probably aware, this is incredibly unsafe, and very likely to
go wrong. Nothing guarantees that (stale) entries remain in the I-cache.

I would very much advise fixing this ASAP.

Thanks,
Mark.
