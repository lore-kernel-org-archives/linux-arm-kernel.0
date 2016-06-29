From: broonie@kernel.org (Mark Brown)
Date: Wed, 29 Jun 2016 20:15:00 +0100
Subject: [alsa-devel] [PATCH v5 7/9] ASoC: bt-sco: extend rate and add a
 general compatible string
In-Reply-To: <1466149440-23889-8-git-send-email-garlic.tseng@mediatek.com>
References: <1466149440-23889-1-git-send-email-garlic.tseng@mediatek.com>
 <1466149440-23889-8-git-send-email-garlic.tseng@mediatek.com>
Message-ID: <20160629191500.GU6247@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 17, 2016 at 03:43:58PM +0800, Garlic Tseng wrote:
> Add supports for 16k (wideband BT) and add a general compatible
> string "linux,bt-sco"

This will claim that we support 16k on existing systems which we clearly
don't.  It also seems unwise to advertise multiple rates when we've no
way to configure the rates...  how does the BT controller figure out
what the sample rate is?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160629/b693362a/attachment.sig>
