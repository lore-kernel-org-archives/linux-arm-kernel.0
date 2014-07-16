From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 16 Jul 2014 21:51:37 +0200
Subject: [PATCH v4 1/8] of: Add NVIDIA Tegra SATA controller binding
In-Reply-To: <53C6908A.2050200@redhat.com>
References: <1405500863-19696-2-git-send-email-mperttunen@nvidia.com>
 <1405510814-31928-1-git-send-email-mperttunen@nvidia.com>
 <53C666E5.6030009@redhat.com> <20140716131306.GB23384@ulmo>
 <53C6908A.2050200@redhat.com>
Message-ID: <20140716195136.GB5212@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16, 2014 at 04:47:38PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 07/16/2014 03:13 PM, Thierry Reding wrote:
> > On Wed, Jul 16, 2014 at 01:49:57PM +0200, Hans de Goede wrote:
> >> Hi,
> >>
> >> On 07/16/2014 01:40 PM, Mikko Perttunen wrote:
> >>> This patch adds device tree binding documentation for the SATA
> >>> controller found on NVIDIA Tegra SoCs.
> >>>
> >>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> >>> ---
> >>> v4: clarify mandatory clock order
> >>
> >> Thanks this and the new v4 of "ata: Add support for the Tegra124 SATA controller"
> >> both look good to me. So these 2 + v3 for the rest of the series are:
> >>
> >> Acked-by: Hans de Goede <hdegoede@redhat.com>
> > 
> > Like I said in my reply to PATCH v3 7/8, I think this mandatory clock
> > order is a mistake.
> 
> We've plenty of other dt bindings where things need to be specified in
> a certain order, e.g. registers. So I don't really see what the problem
> is here.

Like I said, the clock-names exists so that drivers can request a clock
by name. Therefore the order in which they are listed doesn't matter.
The only thing that matters is that the entries in clocks and
clock-names match up.

With the libahci_platform code we completely annul that convention.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140716/3ced75c7/attachment.sig>
