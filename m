From: balbi@ti.com (Felipe Balbi)
Date: Thu, 23 Aug 2012 09:26:47 +0300
Subject: [PATCH v2 00/13] OMAP Serial patches
In-Reply-To: <1345551371-18862-1-git-send-email-balbi@ti.com>
References: <1345540555-24359-1-git-send-email-balbi@ti.com>
 <1345551371-18862-1-git-send-email-balbi@ti.com>
Message-ID: <20120823062646.GC31295@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 21, 2012 at 03:15:58PM +0300, Felipe Balbi wrote:
> Hi guys,
> 
> here's a series of cleanup patches to the OMAP serial
> driver. A later series could be made re-implementing
> DMA using the DMA Engine API. Note that for RX DMA
> we could be using RX Timeout IRQ as a hint that we better
> use PIO instead ;-)
> 
> All patches were tested on my pandaboard, but I'd really
> like to receive Tested-by on other platforms.
> 
> After this goes in, I'll probably try to get UART wakeup
> working again and only after that look at DMA.
> 
> Changes since v1:
> 
> 	. improved commit log on patch 9/13 (formerly 10/13)
> 	. removed patch 2/13
> 	. added a new patch switching from spin_lock_irqsave() to spin_lock and
> 		spin_unlock_irqrestore to spin_unlock
> 
> Retested with my pandaboard, UART continues to work:
> 
>  # grep -i uart /proc/interrupts
>  106:        124          0       GIC  OMAP UART2
>  #  grep -i uart /proc/interrupts
>  106:        189          0       GIC  OMAP UART2
>  #  grep -i uart /proc/interrupts
>  106:        255          0       GIC  OMAP UART2
>  #  grep -i uart /proc/interrupts
>  106:        321          0       GIC  OMAP UART2
>  #  grep -i uart /proc/interrupts
>  106:        387          0       GIC  OMAP UART2
>  #  grep -i uart /proc/interrupts
>  106:        453          0       GIC  OMAP UART2
>  #  grep -i uart /proc/interrupts
>  106:        519          0       GIC  OMAP UART2
> 
> cheers
> 
> ps: if anyone knows a better test for UART, let me know.
> 
> for convenience of anyone testing, patches are available on my git tree [1] on
> branch uart
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git uart

Well, it turns out we found a small issue with one of these patches. We
have already fixed the isse. Will re-send the series soon with a few
more patches added. cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120823/36470e8b/attachment-0001.sig>
