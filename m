From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 2 Apr 2013 18:24:25 +0000 (UTC)
Subject: [PATCH] Revert "OMAP/serial: Fix incorrect Rx FIFO threshold
 setting, LSR validation on Tx, and Tx FIFO IRQ generation"
In-Reply-To: <CAOmKuSo4onVtk2Ke-i+0_1Ych33KuUYspRy+cySRHf4yWB5XDw@mail.gmail.com>
References: <alpine.DEB.2.00.1304010519260.28273@utopia.booyaka.com>
 <CAOmKuSpttQJmrL=Htiz-Zc4voAF7CnG_GQYAO2onKpauwYjtvw@mail.gmail.com>
 <alpine.DEB.2.00.1304010844100.28273@utopia.booyaka.com>
 <CAOmKuSrABrPcZ=Yg1+LAHWbh9CdTYR0eUmJ2dd3z91oz0uu21g@mail.gmail.com>
 <alpine.DEB.2.00.1304011008230.28273@utopia.booyaka.com>
 <CAOmKuSrbDc025Tj9xsqDebJ_KZdp_VnWAOs_OO5UAegV43JcDQ@mail.gmail.com>
 <CAOmKuSpbaKutLxbNihBRDz+B0Wt0XiPss-PcEHc-efCTvciNFg@mail.gmail.com>
 <alpine.DEB.2.00.1304011654520.9148@utopia.booyaka.com>
 <CAOmKuSo4onVtk2Ke-i+0_1Ych33KuUYspRy+cySRHf4yWB5XDw@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1304021821190.27146@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 1 Apr 2013, Alexey Pelykh wrote:

> Paul, can you please try to comment out change related to Rx line
> (granulation one). That's only Rx line related change in the patch.

Yes, looks like simply reverting the commit 1776fd059c40 ("OMAP/serial: 
Fix incorrect Rx FIFO threshold setting, LSR validation on Tx, and Tx FIFO 
IRQ generation") change to OMAP_UART_SCR_RX_TRIG_GRANU1_MASK fixes it.

Care to send a patch doing so ASAP for v3.9-rc fixes?  That would moot the 
revert of the entire commit 1776fd059c40.


- Paul
