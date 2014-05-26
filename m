From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 26 May 2014 14:52:47 -0700
Subject: [RFC PATCH 2/5] clk: Introduce 'clk_round_rate_nearest()'
In-Reply-To: <9956935.0oj56vcaUh@vostro.rjw.lan>
References: <20140521073457.GD31687@pengutronix.de>
 <9956925.Qsz2bH3rDg@vostro.rjw.lan>
 <CAKohpomam0qKdkMMMRDOfWN9QnZ3DzCviV=RuZ5f_7JbmYNDNw@mail.gmail.com>
 <9956935.0oj56vcaUh@vostro.rjw.lan>
Message-ID: <2827f20b-b489-4eb0-8ec9-9db957e28788@BL2FFO11FD008.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-05-26 at 01:47PM +0200, Rafael J. Wysocki wrote:
> On Monday, May 26, 2014 04:37:13 PM Viresh Kumar wrote:
> > On 26 May 2014 16:52, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > I agree as far as the 64-bit thing goes, but is switching to Hz really
> > > necessary?
> > 
> > Don't really know that.. It seems that there will always be problems with
> > close enough frequencies whenever rounding is done.
> 
> Well, rounding errors are a problem, but question is if that is enough of
> a problem to justify expanding the storage size twice.  Also, that'd be
> a performance hit on 32-bit systems.
> 
> > More can be elaborated by Soren.
> 
> OK

I'd say it's probably not worth switching. As you and I said, rounding
issues are likely to happen no matter what. In this particular case,
switching would not remove the need for the patch I proposed to allow
for rounding errors. The error margin could be reduced, but that's it.
I think it would be nice if CCF, OPP and cpufreq would use the same
resolution and types, since it would remove the need for all these
conversions that are going on in cpufreq drivers, but looking at the
wide usage of cpufreq and the potential drawbacks Rafael pointed at:
nice-to-have is probably not enough of a justification.

	S?ren
