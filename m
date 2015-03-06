From: tony@atomide.com (Tony Lindgren)
Date: Fri, 6 Mar 2015 09:07:50 -0800
Subject: [PATCH] ARM: dts: OMAP5: fix polling intervals for thermal zones
In-Reply-To: <20150227213535.GA5633@developer.amazonguestwifi.org>
References: <1425045543-19540-1-git-send-email-t-kristo@ti.com>
 <20150227213535.GA5633@developer.amazonguestwifi.org>
Message-ID: <20150306170749.GT13520@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Eduardo Valentin <edubezval@gmail.com> [150227 13:39]:
> On Fri, Feb 27, 2015 at 03:59:03PM +0200, Tero Kristo wrote:
> > OMAP4 has a finer counter granularity, which allows for a delay of 1000ms
> > in the thermal zone polling intervals. OMAP5 has a different counter
> > mechanism, which allows at maximum a 500ms timer. Adjust the cpu thermal
> > zone polling interval accordingly.
> > 
> > Without this patch, the polling interval information is simply ignored,
> > and the following thermal warnings are printed during boot (assuming
> > thermal is enabled);
> > 
> > [    1.545343] ti-soc-thermal 4a0021e0.bandgap: Delay 1000 ms is not supported
> > [    1.552691] ti-soc-thermal 4a0021e0.bandgap: Delay 1000 ms is not supported
> > [    1.560029] ti-soc-thermal 4a0021e0.bandgap: Delay 1000 ms is not supported
> > 
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> 
> Acked-by: Eduardo Valentin <edubezval@gmail.com>

Applying into omap-for-v4.0/fixes thanks.

Tony
