From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 16 Jun 2012 09:59:57 +0800
Subject: [PATCH v3 2/2] serial: mxs-auart: Allow device tree probing
In-Reply-To: <CAOMZO5BB5G5gvbcqDa2uB3hR-_o7XpcgXR9Ha+Xd7ZLpCqaOVw@mail.gmail.com>
References: <1339774557-23588-1-git-send-email-fabio.estevam@freescale.com>
 <1339774557-23588-2-git-send-email-fabio.estevam@freescale.com>
 <20120615160635.GP31565@S2101-09.ap.freescale.net>
 <CAOMZO5BB5G5gvbcqDa2uB3hR-_o7XpcgXR9Ha+Xd7ZLpCqaOVw@mail.gmail.com>
Message-ID: <20120616015955.GA29663@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 15, 2012 at 01:11:12PM -0300, Fabio Estevam wrote:
> On Fri, Jun 15, 2012 at 1:06 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> 
> >> +MODULE_DEVICE_TABLE(platform, mxs_auart_devtype);
> > ...
> >> + ? ? ? ? ? ? .id_table = mxs_auart_devtype,
> >
> > I do not think we need these.
> 
> WIthout this, the non-dt kernel does not probe correctly.

Are you sure about that?  I just tried to removed those and still
saw the following with non-DT boot.

[    0.810000] mxs-auart.0: ttyAPP0 at MMIO 0x8006a000 (irq = 112) is a mxs-auar t.0
[    0.820000] mxs-auart mxs-auart.0: Found APPUART 3.1.0
[    0.830000] mxs-auart.3: ttyAPP3 at MMIO 0x80070000 (irq = 115) is a mxs-auar t.3
[    0.840000] mxs-auart mxs-auart.3: Found APPUART 3.1.0

-- 
Regards,
Shawn
