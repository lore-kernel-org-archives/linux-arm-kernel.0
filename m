From: broonie@kernel.org (Mark Brown)
Date: Tue, 25 Feb 2014 12:05:00 +0900
Subject: [Patch v7 2/2] dmaengine: add Qualcomm BAM dma driver
In-Reply-To: <20140225000913.GA10801@saruman.home>
References: <1393283500-18599-1-git-send-email-agross@codeaurora.org>
 <1393283500-18599-3-git-send-email-agross@codeaurora.org>
 <20140225000913.GA10801@saruman.home>
Message-ID: <20140225030459.GN25940@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 24, 2014 at 06:09:13PM -0600, Felipe Balbi wrote:

> > +	depends on ARCH_QCOM || (COMPILE_TEST && OF && ARM)

> do you really want to make it depend on ARM even when COMPILE_TEST=y ?

writel_relaxed() is unfortunately not generally available so it'd fail
to build on platforms like x86.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140225/a783bc5b/attachment-0001.sig>
