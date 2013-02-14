From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 14 Feb 2013 12:01:12 +0200
Subject: [PATCH v6 08/10] ARM: dt: Add references to tegra_car clocks
In-Reply-To: <511BC3C3.6070402@wwwdotorg.org>
References: <1360580700-10245-1-git-send-email-pdeschrijver@nvidia.com>
 <1360580700-10245-9-git-send-email-pdeschrijver@nvidia.com>
 <511A7AB5.4040607@wwwdotorg.org>
 <20130213113807.GE3073@tbergstrom-lnx.Nvidia.com>
 <511BC3C3.6070402@wwwdotorg.org>
Message-ID: <20130214100112.GH3073@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 13, 2013 at 05:48:03PM +0100, Stephen Warren wrote:
> On 02/13/2013 04:38 AM, Peter De Schrijver wrote:
> > On Tue, Feb 12, 2013 at 06:24:05PM +0100, Stephen Warren wrote:
> >> On 02/11/2013 04:04 AM, Peter De Schrijver wrote:
> >>> Add references to tegra_car clocks for the basic device nodes.
> >>
> >> In this patch, you also need to remove the "clock-frequency" properties
> >> from tegra114-*.dts board files.
> > 
> > That would probably break bisectability no?
> 
> Oh right, I read the patch order backwards. You can fix this by moving
> this patch to the end of the series.
> 

Probably. Need to check if this doesn't cause other problems.

> > I think this needs to be done in a separate patch.
> 
> To avoid bisect issues, the clock-frequency property should be removed
> in the same patch that adds the clocks property, or after it.
> 
> > Also, the UARTD enabling in init_table[] can then be removed.
> 
> You still need to initialize all the UART clocks in init_table[]. This
> is required to make sure the clocks have the correct parent. Without
> this explicit initialization, on Tegra30 at least, it was found that
> UART C didn't work correctly for Bluetooth since the default parent was
> something that wasn't generating the expected frequency.
> 

Yes. The parent relationships still need to be defined. But I think that's
the only thing we actually need to define still? Also the parent relationships
can be board specific I think in some cases, so maybe we want to move those to
DT as well at some point?

Cheers,

Peter.
