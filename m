From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 28 May 2018 15:20:35 +0800
Subject: [PATCHv4 1/2] ARM: imx53: add secure-reg-access support for PMU
In-Reply-To: <20180528064131.y5burm5kakiazaq4@earth.universe>
References: <20180212123945.15732-1-sebastian.reichel@collabora.co.uk>
 <20180212123945.15732-2-sebastian.reichel@collabora.co.uk>
 <20180224074543.GF3217@dragon>
 <20180226134741.neqkpge33zo3pfzt@earth.universe>
 <20180227011033.GV3217@dragon>
 <20180227101712.3zwobvs4ox4jchcj@earth.universe>
 <20180528022652.GA3143@dragon>
 <20180528064131.y5burm5kakiazaq4@earth.universe>
Message-ID: <20180528072034.GB3143@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 28, 2018 at 08:41:31AM +0200, Sebastian Reichel wrote:
> > Are you saying this is a very specific setup required by i.MX53 only?
> 
> Yes, all other SoCs supported by Linux ARM PMU counters driver can
> just use the registers without having to enable platform specific
> bits first.
> 
> > In that case, I can live with it.
> 
> What about the DT node? I did not add it, since this is a i.MX53
> specific workaround anyways.

What you are adding here is secure-reg-access property, which has an
defined meaning in PMU binding doc.  I'm not really sure if it's
appropriate to use the property as a condition for DBGEN bit setup.
Or can we set up the bit regardless of the property?

Shawn
