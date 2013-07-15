From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 15 Jul 2013 09:27:10 -0700
Subject: [PATCHv5 00/11] MSI support for Marvell EBU PCIe driver
In-Reply-To: <51E4167B.4000208@wwwdotorg.org>
References: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <51E4167B.4000208@wwwdotorg.org>
Message-ID: <20130715162709.GA24625@dhcp-172-17-186-34.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 09:34:19AM -0600, Stephen Warren wrote:
> On 07/15/2013 05:52 AM, Thomas Petazzoni wrote:
> > Hello,
> > 
> > This set of patches introduces Message Signaled Interrupt support in
> > the Marvell EBU PCIe driver. It has been successfully tested on the
> > Armada XP GP platform with an Intel e1000e PCIe network card that
> > supports MSI.
> > 
> > This patch set is intended for merging in 3.12, so the respective
> > maintainers of the different areas are invited to review/ack the
> > patches, see below for the details. This set of patches applies on top
> > of 3.11-rc1.
> 
> Thomas, who is going to merge this series?
> 
> I believe at least patches 1-8 (or perhaps just 1-5 plus 8; I /think/
> all the other patches are MVEBU-specific) are dependencies for the new
> Tegra PCIe driver which should be posted very soon for 3.12. As such,
> I'd like to see these dependencies merged into a standalone stable (100%
> non-rebasable) topic branch based on 3.11-rc1 so that the topic branch
> is available for merging into whichever tree takes the new Tegra PCIe
> driver (which I'm guessing will be the Tegra tree to reduce conflicts).
> So, whoever merges these patches is going to need to know to set up that
> topic branch.
> 
> Thierry, please correct me if I'm wrong here.

We need at least patches 2, 4 and 8 for Tegra. There's still the option
of working around patch 8 by using the custom root bus scan function
that we have to use anyway, so I guess we could even trim the
requirement down to patches 2 and 4 if we really need.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130715/97e67ff4/attachment.sig>
