From: broonie@kernel.org (Mark Brown)
Date: Wed, 13 May 2015 17:21:27 +0100
Subject: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <5553784F.7040905@ti.com>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
 <554FFFA3.1060801@ti.com> <20150512051633.GB32300@linux>
 <555224A2.7000308@ti.com> <20150513050559.GE28858@linux>
 <55536719.5050208@ti.com> <20150513151652.GX2761@sirena.org.uk>
 <5553784F.7040905@ti.com>
Message-ID: <20150513162127.GA2761@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 13, 2015 at 11:14:07AM -0500, Nishanth Menon wrote:

> To illustrate: What does it mean for a driver using regulator API?
> Attempt X <-> (X+Y), if that fails (example PMIC SMPS max < X), try
> (X-Y)<->(X)? If yes, then we do expect (X-Y)<->(X+Y) should be stable
> for all operating conditions for the device, correct? If this is is
> not stable at (X-Y), then we have a wrong specification for the device
> for claiming X +/- Y is a valid range for the device.

We have an explicit regulator API call for setting by tolerance which
tries to get as close as possible to the target voltage (currently the
implementation is very cheap and nasty but ideally it'll get improved).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150513/351d2a9e/attachment.sig>
