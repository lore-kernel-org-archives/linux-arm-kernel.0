From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 22 Feb 2016 16:32:54 -0800
Subject: [PATCH] ARM64: dts: Mediatek: mt8173-evb: fix access MMC fail
 issue
In-Reply-To: <1455861643-24307-1-git-send-email-eddie.huang@mediatek.com>
 (Eddie Huang's message of "Fri, 19 Feb 2016 14:00:43 +0800")
References: <1455861643-24307-1-git-send-email-eddie.huang@mediatek.com>
Message-ID: <7h37skw9jd.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eddie Huang <eddie.huang@mediatek.com> writes:

> MT8173 E1 chip has one bug that if turn off USB power domain, vcore
> power will also be off, thus cause modules using vcore power domain
> fail, like MMC. The E1 chip only found on MT8173-evb board and this
> board only has E1 chip, so implement this as a board specific
> workaround.
>
> Pwrapper use vcore power, so add pwrapper using USB power domain to
> keep USB power domain not to zero and disabled.
>
> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>

Tested-by: Kevin Hilman <khilman@baylibre.com>

I verified that this gets my mt8173-evb booting again when I enable MMC
support.

Thanks,

Kevin
