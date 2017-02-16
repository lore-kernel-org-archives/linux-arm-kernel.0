From: broonie@kernel.org (Mark Brown)
Date: Thu, 16 Feb 2017 20:14:27 +0000
Subject: [RFC v2 4/7] ASoC: dmaengine_pcm: add copy support
In-Reply-To: <338f8db7-2077-626f-986b-b4e3df40469c@st.com>
References: <1487003909-11710-1-git-send-email-arnaud.pouliquen@st.com>
 <1487003909-11710-5-git-send-email-arnaud.pouliquen@st.com>
 <20170214171630.qgkyoymxyqjiiblh@sirena.org.uk>
 <40633f7c-a2ac-1658-cc9d-b30eaff8a95a@st.com>
 <20170215145341.sntwx7oqyqmw6azv@sirena.org.uk>
 <338f8db7-2077-626f-986b-b4e3df40469c@st.com>
Message-ID: <20170216201427.z7ixcwbuyvb7ajgn@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2017 at 04:46:44PM +0100, Arnaud Pouliquen wrote:
> On 02/15/2017 03:53 PM, Mark Brown wrote:
> > On Wed, Feb 15, 2017 at 02:59:18PM +0100, Arnaud Pouliquen wrote:

> > No, copy() is an alternative to doing DMA rather than something
> > that works with DMA.  If you want to have some sort of post
> > processing operation it shoudn't be called copy().  It's probably
> > worth considering just making a new format and letting userspace
> > convert things here.

> You mean using a plug-in alsa to do it? this seems not possible with
> tiny-alsa...
> Without a plug-in, driver will not be compatible with standard audio
> application.

Right.  But if you're using tinyalsa you've got some open coded system
specific stuff anyway!

> Do you think this would be reasonable if i implement something similar
> in my driver, without using the soc generic DMA engine?

Probably.  It might even be possible to fit it elegently into the
generic dmaengine code, just don't say it's a copy() operation since
that's a specific thing in ALSA.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170216/2421aec1/attachment.sig>
