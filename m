From: sean@mess.org (Sean Young)
Date: Mon, 9 Jan 2017 12:39:42 +0000
Subject: [PATCH 2/2] media: rc: add driver for IR remote receiver on
 MT7623 SoC
In-Reply-To: <1483931601.16976.48.camel@mtkswgap22>
References: <1483632384-8107-1-git-send-email-sean.wang@mediatek.com>
 <1483632384-8107-3-git-send-email-sean.wang@mediatek.com>
 <20170105171240.GA9136@gofer.mess.org>
 <1483687885.16976.19.camel@mtkswgap22>
 <20170108211624.GB7866@gofer.mess.org>
 <1483931601.16976.48.camel@mtkswgap22>
Message-ID: <20170109123942.GA15215@gofer.mess.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2017 at 11:13:21AM +0800, Sean Wang wrote:
> I had another question. I found multiple and same IR messages being
> received when using SONY remote controller. Should driver needs to
> report each message or only one of these to the upper layer ?

In general the driver shouldn't try to change any IR message, this should
be done in rc-core if necessary.

rc-core should handle this correctly. If the same key is received twice
within IR_KEYPRESS_TIMEOUT (250ms) then it not reported to the input
layer.

Thanks
Sean
