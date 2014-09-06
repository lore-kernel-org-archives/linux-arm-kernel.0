From: sre@kernel.org (Sebastian Reichel)
Date: Sat, 6 Sep 2014 20:39:20 +0200
Subject: [PATCH v5 5/8] power: reset: move hisilicon reboot code
In-Reply-To: <1406551883-26154-6-git-send-email-haojian.zhuang@linaro.org>
References: <1406551883-26154-1-git-send-email-haojian.zhuang@linaro.org>
 <1406551883-26154-6-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20140906183920.GA17047@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 28, 2014 at 08:51:20PM +0800, Haojian Zhuang wrote:
> Move reboot code from hisilicon platform driver into reset driver.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>
> [...]
> +static struct of_device_id hisi_reboot_of_match[] = {
> +	{ .compatible = "hisilicon,sysctrl" },
> +	{}
> +};
> [...]

The patch looks fine, but it's missing DT Binding
documentation (see Documentation/devicetree/bindings).
Apart from that I suggest to change the compatible value
to something like "hisilicon,reset-sysctrl".

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140906/975b07f4/attachment.sig>
