From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 25 Sep 2012 14:29:48 -0300
Subject: [PATCH] ARM: mxs_defconfig: Improve USB related support
In-Reply-To: <20120925080024.GM27291@S2101-09.ap.freescale.net>
References: <1348541611-15717-1-git-send-email-festevam@gmail.com>
 <20120925080024.GM27291@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5CXgF-tpFsw_s1UFY7yPdJhcwckMo6Mc_zPQsO-Dgh_7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Tue, Sep 25, 2012 at 5:00 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Mon, Sep 24, 2012 at 11:53:31PM -0300, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> Select the following USB related options:
>>
>> - USB Video Class (webcam)
>> - USB Ethernet adapter
>> - Native language support (needed for mounting USB pen drives, for example)
>
> I do not want defconfig/zImage get bloated by these features for
> particular applications.  We should try to maintain a minimum feature
> set that takes care of mxs building and testing coverage.  Anything
> more than that can just be selected by custom configuration.

I didn't mean to bloat mxs_defconfig with these settings.

+CONFIG_USB_USBNET=y
+CONFIG_USB_NET_SMSC95XX=

are needed by mx23-olinuxino so that we can have network support and
can use NFS with this board.

+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_CODEPAGE_850=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_NLS_ISO8859_1

is very useful, so that you can actually mount a USB media. We have
these options in imx_v4_v5_defconfig and imx_v6_v7_defconfig.

If you are not happy with the USB webcam config options, then I can remove it.

Is it OK to send a v2 with USBNET and Language support only?

Just trying to make it easier for the end users.

Regards,

Fabio Estevam
