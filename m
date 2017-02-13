From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 13 Feb 2017 21:05:36 +0800
Subject: [PATCH v4 2/3] ASoC: zx-i2s: Add the info of pclk to the binding
 document for zx2967 family
In-Reply-To: <20170209164645.ztvockrd6jxpybwt@sirena.org.uk>
References: <1486609978-18482-1-git-send-email-baoyou.xie@linaro.org>
 <1486609978-18482-2-git-send-email-baoyou.xie@linaro.org>
 <20170209164645.ztvockrd6jxpybwt@sirena.org.uk>
Message-ID: <20170213130534.GA4151@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 09, 2017 at 04:46:45PM +0000, Mark Brown wrote:
> On Thu, Feb 09, 2017 at 11:12:57AM +0800, Baoyou Xie wrote:
> 
> > - - compatible : Must be "zte,zx296702-i2s"
> > + - compatible : Must be one of:
> > +	"zte,zx296718-i2s", "zte,zx296702-i2s"
> > +	"zte,zx296702-i2s"
> 
> You've added the new compatible twice here?

It's indeed a bit confusing.  Might be better if we add a couple of
bullet like below.

 - compatible : Must be one of:
	- "zte,zx296718-i2s", "zte,zx296702-i2s";
	- "zte,zx296702-i2s";

In this case, it's more easier for readers to understand that the first
one is for I2S device on SoC ZX296718, while it's compatible with the
I2S on ZX296702.

Shawn
