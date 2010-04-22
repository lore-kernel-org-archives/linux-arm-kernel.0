From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 22 Apr 2010 09:08:18 +0900
Subject: [PATCH 1/4] pxa: add namespace on ssp
In-Reply-To: <q2yf17812d71004211517kf54116acxe788927a53048e26@mail.gmail.com>
References: <n2t771cded01004162234sb67befcfp60ba67bfe1a8117f@mail.gmail.com>
	<q2yf17812d71004211517kf54116acxe788927a53048e26@mail.gmail.com>
Message-ID: <20100422000817.GB22879@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 22, 2010 at 06:17:29AM +0800, Eric Miao wrote:
> On Sat, Apr 17, 2010 at 1:34 PM, Haojian Zhuang

> > In order to prevent code ambiguous, add namespace on functions in ssp driver.

> Sorry I'm still not convinced that this is a necessary change, could
> you point me to some place where there are naming conflicts?

Oh, sorry - misread the patch that was being replied to.  The issue is
more around consistency and the fact that ssp_ is pretty short as it is
about specific conflicts that exist.  If the rest of the driver had been
using ssp_ already I wouldn't have said anything but since currently
exported symbols all use pxa2xx_ it seemed better to make newly exported
ones match.
