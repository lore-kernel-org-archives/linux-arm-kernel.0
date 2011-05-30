From: acassis@gmail.com (Alan Carvalho de Assis)
Date: Mon, 30 May 2011 11:24:49 -0300
Subject: Freescale i.mx25 SDIO/Libertas issue
In-Reply-To: <4DE2F84D.8080907@bluewatersys.com>
References: <4DE2F84D.8080907@bluewatersys.com>
Message-ID: <BANLkTi=GSw5HRdiqPB=JcgB9SyEhB1b79A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

On 5/29/11, Andre Renaud <andre@bluewatersys.com> wrote:
> Hello,
> I am trying to use a Wi2Wi 802.11b/g (W2CBW009S) module attached to an
> i.MX25 cpu, specifically the i.MX25 PDK from freescale, although I've
> also tried it on a DeviceSolutions Topaz i.MX25. However it is unable to
> fully load the driver, leaving me with the following in the logs:
> [   30.149097] libertas_sdio mmc0:0001:1: (unregistered net_device):
> command 0x00a9 timed out
> [   30.153759] libertas_sdio mmc0:0001:1: (unregistered net_device):
> Timeout submitting command 0x00a9
> [   30.158843] libertas_sdio mmc0:0001:1: (unregistered net_device):
> PREP_CMD: command 0x00a9 failed: -110
> [   30.164126] libertas_sdio mmc0:0001:1: (unregistered net_device):
> CMD_FUNC_INIT cmd failed
> This wifi chip is based around the Marvell 8688 core.
>
> I have also tried using an 8686 device, and in that case it is unable to
> even complete loading the firmware, failing with the following:
> [   14.753132] libertas_sdio: Firmware req_size: 17
> [   14.755713] libertas_sdio: failed to load firmware: -5
> [   14.759272] libertas_sdio: probe of mmc0:0001:1 failed with error -5
> Note: I added the 'req_size: ' debugging message in
>
> Has anyone successfully used the i.MX25 SDIO controller with anything
> other than straight MMC cards (which seem to work fine in the setup that
> I have)?
>

I used this Marvel WiFi 8686 in our previous product powered by i.MX51
and it worked fine. You need to load the firmware before using it.
Just put your binaries inside firmware directory on linux kernel and
setup your kernel config:

 CONFIG_FW_LOADER=y
 CONFIG_FIRMWARE_IN_KERNEL=y
-CONFIG_EXTRA_FIRMWARE=""
+CONFIG_EXTRA_FIRMWARE="sd8686_helper.bin sd8686.bin"
+CONFIG_EXTRA_FIRMWARE_DIR="firmware"

Best Regards,

Alan
