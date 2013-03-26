From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 26 Mar 2013 18:47:32 +0000 (UTC)
Subject: [PATCHv3 02/14] ARM: OMAP2+: mbox: remove dependencies with soc.h
In-Reply-To: <1363145036-14407-1-git-send-email-s-anna@ti.com>
References: <1363145036-14407-1-git-send-email-s-anna@ti.com>
Message-ID: <alpine.DEB.2.00.1303261845390.23957@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 12 Mar 2013, Suman Anna wrote:

> The OMAP mailbox platform driver code has been cleaned up to
> remove the dependencies with soc.h in preparation for moving
> the mailbox code to drivers folder.
> 
> The code relied on cpu_is_xxx/soc_is_xxx macros previously to
> pick the the right set of mailbox devices and register with the
> mailbox driver. This data is now represented in a concise format
> and moved to the respective omap_hwmod data files and published
> to the driver through the platform data.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>

The hwmod/dev_attr parts look fine to me, but please start thinking about 
how to convert the driver to get this data from DT instead.


- Paul
