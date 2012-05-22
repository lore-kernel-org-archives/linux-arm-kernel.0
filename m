From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 22 May 2012 10:56:35 +0100
Subject: [PATCH V2 00/11] enable imx6q_sabrelite sgtl5000 audio support
In-Reply-To: <20120522013920.GE6206@b20223-02.ap.freescale.net>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
 <20120521125930.GC6206@b20223-02.ap.freescale.net>
 <20120521144543.GA4063@opensource.wolfsonmicro.com>
 <20120522013920.GE6206@b20223-02.ap.freescale.net>
Message-ID: <20120522095635.GD21999@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2012 at 09:39:21AM +0800, Richard Zhao wrote:
> On Mon, May 21, 2012 at 03:45:44PM +0100, Mark Brown wrote:

> >  For the first patch it wasn't clear if the
> > changes in pinctrl were the actual dependencies or if there were more
> > things needed from the ARM tree,

> I remembered someone already explained the dependencies. It depends
> on imx pinctrl work and dummy pinctrl enabled in ARM platform code. It
> is why Shawn suggest it goes to ARM SoC.

There was mention of some changes but only a vauge description of them,
I've no idea where they are or anything, initially people had mentioned
an already cross-merged point in Linus' tree but apparently that wasn't
sufficient due to these arch specific bits and I don't know where those
are.

We should really have got this resolved in -next...

> > Guys, you really need to think about how you're organising what you're
> > doing more.  You need to split your work out into focused lines of
> > development rather than just having a single branch.  

> Except the clean up patch, others are all related to enable audio. Do
> you mean I supposed to split them in advance?

Well, a lot of the time there's no actual dependency (eg, you add a
driver and add registration of that device so there's no need for them
to go in together since both are perfectly fine without the other) then
it is best to merge things separately.  If there are dependencies then
that needs to be handled differently but it needs communication and
ideally the dependencies would be on focused things that can just be
pulled in.  

In the case of things like the devm_clk_get() cleanup if there's any
complexity at all then it's usually best just to punt for a release.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120522/0eb08ec0/attachment.sig>
