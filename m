From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 20 Mar 2013 11:40:18 +0200
Subject: [PATCH] clk: add table lookup to mux
In-Reply-To: <20130319213309.8663.17375@quantum>
References: <1363113747-6572-1-git-send-email-pdeschrijver@nvidia.com>
 <20130319213309.8663.17375@quantum>
Message-ID: <20130320094018.GF18519@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 19, 2013 at 10:33:09PM +0100, Mike Turquette wrote:
> Quoting Peter De Schrijver (2013-03-12 11:42:23)
> > Add a table lookup feature to the mux clock. Also allow arbitrary masks
> > instead of the width. This will be used by some clocks on Tegra114. Also
> > adapt the tegra periph clk because it uses struct clk_mux directly.
> >
> > Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> 
> Do you actually need arbitrary masks instead of a continuous bitfield?
> Or does this change just make it easier for you to convert existing
> data?
> 

Yes we need arbitrary masks. We have some clocks where some bits of the mux
are at the bottom of a 32bit register and other bits are at the top.

Cheers,

Peter.
