From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 08 Nov 2012 20:03:12 -0700
Subject: [PATCH 1/2] arm: bcm2835: move to the multiplatform support
In-Reply-To: <1351419853-25146-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1351419853-25146-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <509C7270.9000508@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/28/2012 04:24 AM, Thomas Petazzoni wrote:
> This commit integrates the bcm2835 into the list of platforms
> supported by the multiplatform mechanism, which makes it possible to
> build a single kernel binary image that boots on various SoCs.
...
> ---
> Note that if you have CONFIG_VFP enabled, you need "[PATCH v3] ARM:
> vfp: fix save and restore when running on pre-VFPv3 and CONFIG_VFPv3
> set" to be applied in order to avoid a VFP-related kernel panic when
> starting the first userspace application. Thanks to Albin Tonnerre for
> pointing me to the right fix for this problem!

Thomas, just a heads up - the VFP commit you mention above should show
up in v3.7-rc5 which I imagine will be released this weekend, and the
debug_ll_io_init feature I mentioned in another response is already
available is arm-soc branch devel/debug_ll_init. If you rebase this
patch on a merge of those two branches, it should be in good shape for
me to apply it.

Thanks.
