From: broonie@kernel.org (Mark Brown)
Date: Wed, 15 Feb 2017 14:53:41 +0000
Subject: [RFC v2 4/7] ASoC: dmaengine_pcm: add copy support
In-Reply-To: <40633f7c-a2ac-1658-cc9d-b30eaff8a95a@st.com>
References: <1487003909-11710-1-git-send-email-arnaud.pouliquen@st.com>
 <1487003909-11710-5-git-send-email-arnaud.pouliquen@st.com>
 <20170214171630.qgkyoymxyqjiiblh@sirena.org.uk>
 <40633f7c-a2ac-1658-cc9d-b30eaff8a95a@st.com>
Message-ID: <20170215145341.sntwx7oqyqmw6azv@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2017 at 02:59:18PM +0100, Arnaud Pouliquen wrote:

> For DFSDM we need to re-arrange samples after DMA transfer, before
> sending them to application.
> For this, a copy ops(called in snd_pcm_lib_read_transfer) alreday exists
> in snd_pcm_ops struct.

No, copy() is an alternative to doing DMA rather than something that
works with DMA.  If you want to have some sort of post processing
operation it shoudn't be called copy().  It's probably worth considering
just making a new format and letting userspace convert things here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170215/be4ffe3f/attachment.sig>
