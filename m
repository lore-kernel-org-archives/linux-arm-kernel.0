From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 14 Aug 2013 11:07:24 +0200
Subject: [PATCH v2 4/5] PCI: mvebu: add support for reset on GPIO
In-Reply-To: <1376396724-32048-5-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1376396724-32048-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376396724-32048-5-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130814090715.GA2084@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 13, 2013 at 02:25:23PM +0200, Sebastian Hesselbarth wrote:
[...]
> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
[...]
> @@ -897,6 +904,30 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
[...]
> +			u32 reset_udelay = 20000;
[...]
> +			udelay(reset_udelay);

udelay(20000) is probably not a good idea. You should probably use
something like usleep_range() or msleep() here. Also see:

	Documentation/timers/timers-howto.txt

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130814/60f5504d/attachment.sig>
