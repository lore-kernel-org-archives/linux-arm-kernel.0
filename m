From: broonie@kernel.org (Mark Brown)
Date: Tue, 14 Feb 2017 17:16:30 +0000
Subject: [RFC v2 4/7] ASoC: dmaengine_pcm: add copy support
In-Reply-To: <1487003909-11710-5-git-send-email-arnaud.pouliquen@st.com>
References: <1487003909-11710-1-git-send-email-arnaud.pouliquen@st.com>
 <1487003909-11710-5-git-send-email-arnaud.pouliquen@st.com>
Message-ID: <20170214171630.qgkyoymxyqjiiblh@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2017 at 05:38:26PM +0100, Arnaud Pouliquen wrote:
> From: olivier moysan <olivier.moysan@st.com>
> 
> Add copy support in pcm damengine operations.
> As example, this allows to:
> - process data before rendering (IEC status insertion),
> - process captured sample ( sample mask and shift).

dmaengine with copy...  so not DMA at all?  I'm a bit confused about why
we're extending the dmaengine code to have a copy operation rather than
just writing driver code.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170214/1121fff1/attachment.sig>
