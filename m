From: broonie@kernel.org (Mark Brown)
Date: Fri, 19 Oct 2018 17:06:22 +0100
Subject: [PATCH 1/1] ASoC: cs42l51: fix mclk support
In-Reply-To: <1539964595-23758-1-git-send-email-olivier.moysan@st.com>
References: <1539964595-23758-1-git-send-email-olivier.moysan@st.com>
Message-ID: <20181019160622.GO5895@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2018 at 05:56:35PM +0200, Olivier Moysan wrote:
> Fixes: 5e8d63a726f8 ("ASoC: cs42l51: add mclk support")
> 
> The MCLK clock is made optional for cs42l51 codec.
> However, ASoC DAPM clock supply widget, expects the clock to be defined
> unconditionally.
> Register MCLK DAPM conditionally in codec driver,
> depending on clock presence in DT.

I've applied this but TBH I think we should be doing this in the core -
I actually thought we had handling for that but I can't see it so I'm
obviously imagining things.  It's something that can be done later
anyway.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181019/76b59e53/attachment.sig>
