From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 14 Dec 2012 11:46:28 +0900
Subject: [PATCH 02/12] regulator: gpio-regulator: Only read GPIO
 [dis|en]able pin if not always-on
In-Reply-To: <20121213114818.GH27617@gmail.com>
References: <1355129761-8088-1-git-send-email-lee.jones@linaro.org>
 <1355129761-8088-3-git-send-email-lee.jones@linaro.org>
 <20121210141000.GC6103@opensource.wolfsonmicro.com>
 <20121213114818.GH27617@gmail.com>
Message-ID: <20121214024626.GA4478@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 13, 2012 at 11:48:18AM +0000, Lee Jones wrote:
> On Mon, 10 Dec 2012, Mark Brown wrote:
> > On Mon, Dec 10, 2012 at 08:55:51AM +0000, Lee Jones wrote:
> > > If a regulator is specified as always-on, then it can't have an
> > > enable/disable pin, as it can't be turned off.

> > Sometimes always on gets set for regulators which do have a physical
> > control wired up - the control might exist for use in suspend mode for
> > example.  Is the ability to specify an enable pin causing a practical
> > problem for systems?  If it is we should fix that.

> My logic is that there is no point in requesting a pin which can
> disable a regulator that can't be disabled. Then we can follow
> on from that logic and say that if a regulator is _not_ always on
> this we _require_ a way to disable it, thus we insist on an enable
> GPIO pin.

> With me?

No.  Making the enable pin optional for always on regulators is fine,
forbidding it is not - that won't work for things like the suspend case
I mentioned.
