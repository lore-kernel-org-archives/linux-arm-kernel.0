From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 12 Feb 2014 23:20:52 +0800
Subject: [PATCH] ARM: dts: imx6qdl-sabresd: Do not place regulator nodes
 under simple-bus
In-Reply-To: <20140212135736.GB25957@e106331-lin.cambridge.arm.com>
References: <1392165078-25794-1-git-send-email-festevam@gmail.com>
 <20140212092227.GA24834@S2101-09.ap.freescale.net>
 <20140212095450.GB21992@e106331-lin.cambridge.arm.com>
 <20140212122837.GD24834@S2101-09.ap.freescale.net>
 <20140212135736.GB25957@e106331-lin.cambridge.arm.com>
Message-ID: <20140212152050.GA28749@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 01:57:36PM +0000, Mark Rutland wrote:
> As it stands, the dts are buggy. I can appreciate that you don't feel
> this is important, but I do. It's not just an IMX issue, there is
> widespread misunderstanding and abuse of simple-bus.
> 
> Said abuse is relying on current Linux implementation details, and that
> can and will create problems if and when probing code is changed.

The reality is the code already gets no chance to change on this regard,
considering the requirement that we need to maintain the interface
between kernel and DT as ABI.  The dts have been there like this for
10 kernel releases or so.

> There's no good reason for abusing the binding when we can get it right
> today.

As I said from the beginning, though I personally take it as a churn, I
will still be happy take the change, as long as my upstream folks are
also fine with it.

Shawn
