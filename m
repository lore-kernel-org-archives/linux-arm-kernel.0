From: b32955@freescale.com (Huang Shijie)
Date: Mon, 12 May 2014 16:17:16 +0800
Subject: [PATCH 1/5] serial: imx: remove unneeded imx_transmit_buffer()
 from imx_start_tx()
In-Reply-To: <53708049.8060108@mentor.com>
References: <1399648788-26061-1-git-send-email-dean_jenkins@mentor.com>
 <1399648788-26061-2-git-send-email-dean_jenkins@mentor.com>
 <537042B5.2040600@freescale.com> <53706014.8010203@de.bosch.com>
 <53706A9A.6060707@freescale.com> <53706CC3.4030907@de.bosch.com>
 <53706FD8.6090201@freescale.com> <53708049.8060108@mentor.com>
Message-ID: <5370838C.4060300@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2014?05?12? 16:03, Dean Jenkins ??:
> Well, the locking might now be OK but due to an existing issue the TX 
> will be woken up excessively with no new characters to transmit so 
> there will be excessive context switching with the new work queue that 
> results in no useful work done. There is an API issue in HCI LDISC 
> because TTY_DO_WRITE_WAKEUP is set BEFORE checking whether any 
> characters remain pending to be sent. This means most of the time 
> hci_uart_tx_wakeup() is unnecessarily called will no chance of seeing 
> any remain pending characters to be process. This weakness contributed 
> to triggering lockup issue.
>
You can send a patch to fix the Bluetooth code. :)
I am happy if you can improve the Bluetooth.

thanks
Huang Shijie
