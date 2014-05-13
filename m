From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 13 May 2014 11:13:54 -0400
Subject: [PATCH 0/2] ARM: mvebu: fix PCIe/mvebu-soc-id issue
In-Reply-To: <1399903900-29977-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1399903900-29977-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140513151354.GA27822@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 12, 2014 at 04:11:38PM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> This set of two patches (and more specifically the second patch) fix a
> PCIe detection problem caused by the introduction of the mvebu-soc-id
> and a bad interaction between the clock manipulation done by the
> mvebu-soc-id code and the PCIe driver. The details are all in the
> commit log of the second patch.
> 
> This second patch fixes a PCIe detection problem noticed by several
> persons. The first patch is just a related preparation patch.
> 
> Both patches are meant for 3.15-rc, and should be backported to 3.14
> as part of the stable process.
> 
> Best regards,
> 
> Thomas
> 
> Thomas Petazzoni (2):
>   ARM: mvebu: mvebu-soc-id: add missing clk_put() call
>   ARM: mvebu: mvebu-soc-id: keep clock enabled if PCIe unit is enabled
> 
>  arch/arm/mach-mvebu/mvebu-soc-id.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Series applied to mvebu/fixes with Gregory's Ack, and Tested-by's from
Gregory, Andrew, and Willy.

Also, as Rob noted, if you are going to add 'Fixes' tags, please do so
in the following format:

  Fixes: af8d1c63afcb ("ARM: mvebu: Add support to get the ID and the revision of a SoC")

Note that it uses double quotes, and only 12 characters for the hash.

Also, the second patch depends on the first, so I've amended the tags as
such for the second patch:

  Fixes: af8d1c63afcb ("ARM: mvebu: Add support to get the ID and the revision of a SoC")
  Cc: <stable@vger.kernel.org> # 3.14+: 42a18d1cf484: ARM: mvebu: mvebu-soc-id: add missing clk_put() call
  Cc: <stable@vger.kernel.org> # 3.14+

Keep in mind, I don't require any of this.  I /ask/ for the commit hash
of the commit introducing the regression, just to make my job easier.
If you are going to put it in the Fixes format, great.

As for the stable tags, you can't very well add the dependency info
since you don't have the commit hash of the first patch yet. :)

Thanks for all the effort diagnosing this problem and finding the fix!

thx,

Jason.
