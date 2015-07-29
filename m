From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 29 Jul 2015 15:57:29 +0800
Subject: [PATCH 07/10] usb: chipidea: usbmisc_imx: add unburst setting
 for imx6
In-Reply-To: <20150729103022.7cfe0466@ipc1.ka-ro>
References: <1438137734-27311-1-git-send-email-peter.chen@freescale.com>
 <1438137734-27311-8-git-send-email-peter.chen@freescale.com>
 <20150729103022.7cfe0466@ipc1.ka-ro>
Message-ID: <20150729075728.GC27605@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 29, 2015 at 10:30:22AM +0200, Lothar Wa?mann wrote:
> Hi,
> 
> > With this setting and AHBBRST at SBUSCFG as "Incremental burst of
> > unspecified length", each unburst size can be taken as one single transfer.
> > It is benefit for unburst size transfer.
> > 
> What is an 'unburst'?
> 

Assume burst size is 8 dword, unburst size 't' < 8.

With this feature, 't' length payload can be taken
as one burst transfer, otherwise, the single transfer
(1 dword) will be used.

-- 

Best Regards,
Peter Chen
