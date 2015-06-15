From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 15 Jun 2015 16:48:10 +0200
Subject: [PATCH 1/2] net: mvneta: introduce tx_csum_limit property
In-Reply-To: <20150615143601.GM7557@n2100.arm.linux.org.uk>
References: <1434378443-23029-1-git-send-email-simon.guinot@sequanux.org>
 <1434378443-23029-2-git-send-email-simon.guinot@sequanux.org>
 <20150615143601.GM7557@n2100.arm.linux.org.uk>
Message-ID: <20150615164810.0f3c8c8d@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Mon, 15 Jun 2015 15:36:01 +0100, Russell King - ARM Linux wrote:
> On Mon, Jun 15, 2015 at 04:27:22PM +0200, Simon Guinot wrote:
> > This patch introduces the tx_csum_limit DT property. This allows to
> > configure the maximum frame size for which the Ethernet controller is
> > able to perform TCP/IP checksumming. If MTU is set to a value greater
> > than tx_csum_limit, then the features NETIF_F_IP_CSUM and NETIF_F_TSO
> > are disabled.
> > 
> > Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> > Cc: <stable@vger.kernel.org> # v3.8+
> 
> Sorry, I just tripped over this.  This looks like a patch adding a new
> _feature_ to this ethernet driver.  It isn't a regression fix, and it
> isn't a bug fix.  Why are you wanting to get it into stable kernels,
> which are supposed to only have bug and regression fixes applied?

Look at the cover letter, it is fixing a bug.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
