From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Mar 2013 12:16:13 +0000
Subject: [PATCH v2] ARM: tegra: expose chip ID and revision
In-Reply-To: <1363089667-15737-1-git-send-email-dahuang@nvidia.com>
References: <1363089667-15737-1-git-send-email-dahuang@nvidia.com>
Message-ID: <20130312121613.GT4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 12, 2013 at 08:01:07PM +0800, Danny Huang wrote:
> +	if (IS_ERR_OR_NULL(soc_dev))

Sigh.  NAK.  Fur cryin out loud!  Use the IS_ERR() version.

And you don't need the following "return;" statement - that's already
implied at the closing brace of a function.
