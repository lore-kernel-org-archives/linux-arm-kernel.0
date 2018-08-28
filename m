From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Tue, 28 Aug 2018 13:00:02 +0000
Subject: [RESEND] PCI: imx: Initial imx7d pm support
In-Reply-To: <20180828100758.GA27217@e107981-ln.cambridge.arm.com>
References: <d577303de61fb060aa428898f5df1d0bc9be89b8.1535369231.git.leonard.crestez@nxp.com>
 <20180828100758.GA27217@e107981-ln.cambridge.arm.com>
Message-ID: <efcb160f08bb53620ba0570e55dbb9190275aeb0.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-08-28 at 11:07 +0100, Lorenzo Pieralisi wrote:
> On Mon, Aug 27, 2018 at 02:28:37PM +0300, Leonard Crestez wrote:
> > On imx7d the pcie-phy power domain is turned off in suspend and this can
> > make the system hang after resume when attempting any read from PCI.
> > 
> > Fix this by adding minimal suspend/resume code from the nxp internal
> > tree. This will prepare for powering down on suspend and reset the block
> > on resume.
> > 
> > Code is only for imx7d but a very similar sequence can be used for
> > other socs.
> > 
> > The original author is mostly Richard Zhu <hongxing.zhu@nxp.com>, this
> > patch adjusts the code to the upstream imx7d implemention using reset
> > controls and power domains.
> 
> I will add a Suggested-by: replacing this paragraph, it is always better
> to add proper tags rather than credit hidden in commit logs messages.

Isn't "Originally-by:" a better tag for this?

> > Some dependencies in this area are complicated but as far as I know
> > including this patch without others should not break anything that was
> > not already broken. Since this is a patch for something that has never
> > worked before it should be treated as a feature not a bugfix.
> 
> Ok, so I consider this v4.20 material, please shout if it has to be
> sent as a fix, I do not think so given what we discussed above.

Thanks!
