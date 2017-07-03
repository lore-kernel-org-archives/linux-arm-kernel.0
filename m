From: broonie@kernel.org (Mark Brown)
Date: Mon, 3 Jul 2017 16:07:33 +0100
Subject: [RFC 0/5] drivers: Add boot constraints core
In-Reply-To: <20170703061552.GB3532@vireshk-i7>
References: <CAGb2v64UabHPN79-zFzgxhsJwPF=fe_dM8jwnbxj_XR4LzsnwQ@mail.gmail.com>
 <20170630035533.GV29665@vireshk-i7>
 <CAGb2v67hxVciKFLD=8pgfm+UJ1i2Zb0aByTEa556O5uGcX7Oug@mail.gmail.com>
 <20170630041211.GX29665@vireshk-i7>
 <CAGb2v641UyXS5ccmo0j9Dvty8soB+DqwF2w8zKHsM78oK7b1aw@mail.gmail.com>
 <20170630051203.GY29665@vireshk-i7>
 <CAGb2v64CE2cUKgFuXd0f+FEdzQqmpOgMWqk76RndjeOz98=H0A@mail.gmail.com>
 <20170630084330.GB29665@vireshk-i7>
 <20170630121026.azppihjqls5i6bbr@sirena.org.uk>
 <20170703061552.GB3532@vireshk-i7>
Message-ID: <20170703150733.sop6yrrpfl3ne32g@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 03, 2017 at 11:45:52AM +0530, Viresh Kumar wrote:
> On 30-06-17, 13:10, Mark Brown wrote:
> > On Fri, Jun 30, 2017 at 02:13:30PM +0530, Viresh Kumar wrote:
> > > On 30-06-17, 14:36, Chen-Yu Tsai wrote:

> > > And so the DT node shall have this:

> > >         regulator-min-microvolt = <1800000>;
> > >         regulator-max-microvolt = <3000000>;

> > > Isn't it ?

> > If the DMA can't tolerate more than 2.5V then why would the constraints
> > allow the voltage to float that far?  Similarly on the low end?

> The above regulator-min/max-microvolt values I mentioned were for the regulator
> device and not what the consumers would request. Yes, DMA will request something

If you're putting the maximum possible range that the physical regulator
can supply into machine constraints then you really haven't understood
what machine constraints are at all.

> > Please remember that devices shouldn't be managing their voltages unless
> > they are actively changing them at runtime, simply setting them at
> > startup is the job of the constraints.  I would be very surprised to see
> > a DMA controller doing anything like DVFS.

> Sure, DMA would most likely set a constraint from probe. Maybe I could have used

No, it really shouldn't.  Please read what I wrote.

> MMC in the above example, which may actually do DVFS at runtime.

Yes, MMC does vary voltage.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170703/deb26cc4/attachment-0001.sig>
