From: robh@kernel.org (Rob Herring)
Date: Mon, 9 May 2016 15:13:24 -0500
Subject: [PATCH 0/2] mtd: atmel_nand: remove compatible "atmel,sama5d4-nfc"
In-Reply-To: <1462776680-5284-1-git-send-email-wenyou.yang@atmel.com>
References: <1462776680-5284-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20160509201324.GA9845@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 09, 2016 at 02:51:17PM +0800, Wenyou Yang wrote:
> It is a datasheet bug, for current SoCs, the RB_EDGE3(i.e. bit 27)
> of HSMC_SR register does not exist, the RB_EDGE0 (i.e. bit 24) is
> the ready/busy line edge status bit. So the compatible
> "atmel,sama5d4-nfc" is unneeded.

The compatible is needed if the SOC still exists. You can list both for 
the sama5d4 if the block is the same.

Rob
