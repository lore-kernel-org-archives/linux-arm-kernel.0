From: broonie@kernel.org (Mark Brown)
Date: Fri, 30 Jun 2017 13:12:36 +0100
Subject: [RFC 0/5] drivers: Add boot constraints core
In-Reply-To: <CAGb2v641UyXS5ccmo0j9Dvty8soB+DqwF2w8zKHsM78oK7b1aw@mail.gmail.com>
References: <cover.1498642745.git.viresh.kumar@linaro.org>
 <beab4875-8dd7-43d7-9ad2-6e38963d7d4c@gr13.net>
 <20170629144711.GO29665@vireshk-i7>
 <1522ae7b-fd5b-5403-62bf-b0140e116d65@gr13.net>
 <20170630031648.GR29665@vireshk-i7>
 <CAGb2v64UabHPN79-zFzgxhsJwPF=fe_dM8jwnbxj_XR4LzsnwQ@mail.gmail.com>
 <20170630035533.GV29665@vireshk-i7>
 <CAGb2v67hxVciKFLD=8pgfm+UJ1i2Zb0aByTEa556O5uGcX7Oug@mail.gmail.com>
 <20170630041211.GX29665@vireshk-i7>
 <CAGb2v641UyXS5ccmo0j9Dvty8soB+DqwF2w8zKHsM78oK7b1aw@mail.gmail.com>
Message-ID: <20170630121236.dqbya3gh5r5mi5xk@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 30, 2017 at 12:22:13PM +0800, Chen-Yu Tsai wrote:

> What I'm saying is for the DT case, the constraints are already limited
> to the intersection of all users, regardless of whether they are turned
> on or not. At least this is what I believe makes sense. You really don't
> want to set a regulator such that it over voltages for a subset of its
> consumers. Consumers might not have proper power isolation for this.

Right, and we also shouldn't have voltage setting code in consumers that
don't need to vary their voltage at runtime.  This keeps complexity out
of drivers and avoids the need to handle things like variants that have
different power requirements.

> I think what you mean is that the DT constraints are the union of all
> consumer constraints (1.8 - 3.0 V in this case), then each consumer
> comes in and adds its own constraints. And for such a design, the kernel
> needs to know which and what constraints to apply.

That's the broad idea.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170630/313a42b0/attachment.sig>
