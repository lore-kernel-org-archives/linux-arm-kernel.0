From: marex@denx.de (Marek Vasut)
Date: Fri, 22 May 2015 01:31:23 +0200
Subject: [RFC PATCH 1/1] pci-imx6: add speed change timeout message
In-Reply-To: <555E6795.6090009@boundarydevices.com>
References: <1432233345-10160-1-git-send-email-troy.kisky@boundarydevices.com>
 <201505212319.47974.marex@denx.de> <555E6795.6090009@boundarydevices.com>
Message-ID: <201505220131.23825.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, May 22, 2015 at 01:17:41 AM, Troy Kisky wrote:
> On 5/21/2015 2:19 PM, Marek Vasut wrote:
> > On Thursday, May 21, 2015 at 08:35:45 PM, Troy Kisky wrote:
> >> Currently, the timeout is never detected as count
> >> has a value of -1 if a timeout happens, but the code is checking
> >> for 0.
> >> 
> >> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> >> 
> >> ---
> >> 
> >> This patch breaks pcie for imx6sx as my board always times out.
> >> So, if someone could check this on an imx6sx I'd appreciate it.
> >> 
> >> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> >> ---
> >> 
> >>  drivers/pci/host/pci-imx6.c | 18 ++++++++++--------
> >>  1 file changed, 10 insertions(+), 8 deletions(-)
> >> 
> >> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> >> index fdb9536..51be92c 100644
> >> --- a/drivers/pci/host/pci-imx6.c
> >> +++ b/drivers/pci/host/pci-imx6.c
> >> @@ -398,20 +398,22 @@ static int imx6_pcie_start_link(struct pcie_port
> >> *pp)
> >> 
> >>  	writel(tmp, pp->dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
> >>  	
> >>  	count = 200;
> >> 
> >> -	while (count--) {
> > 
> > Uh, wouldn't "while (--count)" fix this as well, with a smaller patch?
> > 
> > Best regards,
> > Marek Vasut
> 
> Yes, but you'd have an unnecessary usleep_range (no check for finished
> after it) if a timeout happens.

Oki, then I'll wait for Fabio to ACK this and that'd be it :)

Thanks!

Best regards,
Marek Vasut
