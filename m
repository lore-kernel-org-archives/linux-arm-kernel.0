From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 16 Jul 2013 16:27:09 -0700
Subject: [PATCH v2 06/22] ARM: dt: tegra114: iommu: Fix IOMMU register
 address
In-Reply-To: <51E5D4C5.4090109@wwwdotorg.org>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
 <1373021097-32420-7-git-send-email-hdoyu@nvidia.com>
 <51E5D4C5.4090109@wwwdotorg.org>
Message-ID: <20130716232708.GB12189@dhcp-172-17-186-34.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 16, 2013 at 05:18:29PM -0600, Stephen Warren wrote:
> On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
> > Fix IOMMU register address.
> 
> Oh dear, how serious is this?
> 
> That incorrect node got added in v3.9 - a long time ago. Does the SMMU
> driver touch registers during probe() or under any other condition right
> now? If so, can that hang the CPU or end up trashing some other HW
> module's registers?
> 
> I'm trying to determine whether we need to urgently send this patch as a
> fix Cc: stable.

Judging by the TRM there's nothing in the range from 0x7000ec00 to
0x7000f7ff, so hopefully we got lucky.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130716/346a833a/attachment.sig>
