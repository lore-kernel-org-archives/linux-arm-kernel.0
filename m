From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Tue, 04 Sep 2018 20:06:52 +0200
Subject: [PATCH 05/27] clk: sunxi-ng: Use u64 for calculation of NM rate
In-Reply-To: <CAGb2v64Y0ui6ZvAJqc2dXMKtSSQJ-T4ubrV9188JTV7aFSrFCA@mail.gmail.com>
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
 <20180902072643.4917-6-jernej.skrabec@siol.net>
 <CAGb2v64Y0ui6ZvAJqc2dXMKtSSQJ-T4ubrV9188JTV7aFSrFCA@mail.gmail.com>
Message-ID: <4377030.YGBN1y1aZP@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne torek, 04. september 2018 ob 11:18:47 CEST je Chen-Yu Tsai napisal(a):
> On Sun, Sep 2, 2018 at 3:27 PM Jernej Skrabec <jernej.skrabec@siol.net> 
wrote:
> > Allwinner H6 SoC has multiplier N range between 1 and 254. Since parent
> > rate is 24MHz, intermediate result when calculating final rate easily
> > overflows 32 bit variable.
> > 
> > Because of that, introduce function for calculating clock rate which
> > uses 64 bit variable for intermediate result.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> 
> The code looks good. The A80's Video PLLs are also affected by this.
> The range for N on the A80 is 12 ~ 255.
> 
> Can you add fixes and stable tags?

Sure.

> 
> ChenYu
