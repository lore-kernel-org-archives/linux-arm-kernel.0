From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 7 Oct 2010 11:42:46 -0300
Subject: linux hang on i.mx35 board, a sdma problem?
In-Reply-To: <201010071623.54903.alexander.stein@systec-electronic.com>
References: <201010071623.54903.alexander.stein@systec-electronic.com>
Message-ID: <AANLkTinCV62zrsiU51Vzz+eSKpS4E8BD2M6StnzWmrkK@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander,

On Thu, Oct 7, 2010 at 11:23 AM, Alexander Stein
<alexander.stein@systec-electronic.com> wrote:
> Hello,
>
> I'm currently developing on an i.mx35 board (http://www.ic-
> board.de/product_info.php?info=p159_ICnova-i-MX353-OEM.html) (I use the
> mx35_pdk config for linux kernel)
> and noticed a strange behavior. If I run it while openocd is attached to JTAG
> linux stops/seem to stop during boot after initializing FEC. But if I stop the
> execution and attach gdb I can see it loops inside default_idle. After
> removing the fec driver the same goes until the first few chars printed from
> busybox init (run from initramfs).
> If I don't attach openocd to JTAG, the system boots fine, but I cannot attach
> openocd to the running linux system.

Pass 'nohlt' in your kernel command line when you boot Linix with the
JTAG cable connected.

Regards,

Fabio Estevam
