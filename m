From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 02 Mar 2012 12:20:32 -0700
Subject: [PATCH 1/3 v3] spi: move master of_node init to spi_alloc_master
In-Reply-To: <1330682587-20636-1-git-send-email-plagnioj@jcrosoft.com>
References: <1330682587-20636-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20120302192032.3ACF33E1C63@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  2 Mar 2012 11:03:05 +0100, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> wrote:
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: spi-devel-general at lists.sourceforge.net
> Cc: Grant Likely <grant.likely@secretlab.ca>

Actually, the of_node pointer setting was purposefully left out
of spi_alloc_master() because it is not necesarily true that the
dt node associated with the struct device will be the node where
all the spi children are parented.  I want to leave this
initialization in the drivers.

g.
