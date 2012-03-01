From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 1 Mar 2012 11:30:32 +0000
Subject: [PATCH v5 1/2] mfd: Add anatop mfd driver
In-Reply-To: <1330593052-15184-1-git-send-email-paul.liu@linaro.org>
References: <1330593052-15184-1-git-send-email-paul.liu@linaro.org>
Message-ID: <20120301113031.GD3124@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2012 at 05:10:51PM +0800, Ying-Chun Liu (PaulLiu) wrote:

> +	spin_lock(&adata->reglock);
> +	val = readl(adata->ioreg + addr);
> +	spin_unlock(&adata->reglock);

Do you really need to take a lock for a single read operation from a
memory mapped register?  I'd expect this to be atomic in itself.  You
need to lock on read/modify/write cycles to make sure that you don't get
a read/read/modify/modify/write/write and misplace one of the modifies
but that's not an issue for an isolated read.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120301/65ce9750/attachment.sig>
