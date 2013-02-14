From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 13 Feb 2013 21:40:39 -0700
Subject: of_clk_get() / devm_clk_get()
In-Reply-To: <1360815425.21991.20.camel@gitbox>
References: <1360815425.21991.20.camel@gitbox>
Message-ID: <511C6AC7.6010601@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/13/2013 09:17 PM, Tony Prisk wrote:
> Currently we have devm_clk_get() which gives a managed-resource clk (by
> name), or of_clk_get() which gives an unmanaged resource clk (by id).
> 
> I just wanted to sound out everyone as to whether there is a need for a
> managed version of the of_clk_get.
> 
> My personal concern about devm_clk_get is that it requires (if I
> understand correctly) that the DT node have the clock-names property
> (which is optional). If the optional name is not supplied, it fails.
> This basically makes it 'not optional' when a driver uses devm_clk_get.
> (Please correct me if I'm wrong about this).

I thought supplying NULL for the name/ID simply gave you the first clock
in the list (clocks property)? I'm sure I've seen plenty of Tegra
drivers that end up doing that.
