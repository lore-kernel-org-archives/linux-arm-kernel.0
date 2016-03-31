From: broonie@kernel.org (Mark Brown)
Date: Thu, 31 Mar 2016 09:39:19 -0700
Subject: [PATCH] ACPI / ARM64: Remove EXPERT dependency for ACPI on ARM64
In-Reply-To: <CAKv+Gu_TfX8aOXig63gWH535he-dPiMr14ig7bUL+LJC_n3=9Q@mail.gmail.com>
References: <1459360718-24125-1-git-send-email-broonie@kernel.org>
 <56FC9D1D.6090808@huawei.com>
 <CAJZ5v0gv-MJ+Ss8gtc80z2_sOq-3qfBYbspRU8MWRNvn+UVbUg@mail.gmail.com>
 <20160331123649.GE18910@arm.com>
 <CAKv+Gu_i8q_xKQgJ1mJ5hE_gcdJgHkh_QZhUNwQchsyH9r-pJQ@mail.gmail.com>
 <20160331133848.GH18910@arm.com>
 <CAKv+Gu_TfX8aOXig63gWH535he-dPiMr14ig7bUL+LJC_n3=9Q@mail.gmail.com>
Message-ID: <20160331163919.GC2350@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2016 at 04:48:44PM +0200, Ard Biesheuvel wrote:
> On 31 March 2016 at 15:38, Will Deacon <will.deacon@arm.com> wrote:

> > I'd really like to get away from the concept of ACPI-only systems. Would
> > we reject a .dtb contribution for such a machine?

> Absolutely not, and I expect such contributions will appear sooner
> rather than later.

> But the point of ACPI is the abstraction, and the ridiculous churn in
> DTB's carried in mainline clearly shows the need for that*. So there
> will be ACPI-only systems because the drivers are coded against the
> abstracted interface, and DT is simply not a drop-in replacement in
> that case.

It's also worth remembering that just because we have a DT in tree that
doesn't mean that people running actual systems are going to use it.
For some systems there will be a user community that wants to do that
but that won't be universal, there are going to be people who just use
the default firmware.

> > I understand that, but I still think that removing the dependency on
> > EXPERT is indicative of saying "this stuff is good to be used by the
> > masses", irrespective of a cmdline option. Maybe that's true, but it's
> > not immediately obvious to me, with all the patches in flight.

> Well, we are not cc'ing to stable, are we? Or do you think the current
> stuff is so broken that we should even protect users of the upstream
> HEAD branch against it?

Like I said in the other mail I'm also just not sure that this is
something that people deciding what firmware to ship on their systems
are paying much attention to.  People are coming to their own assessment
based on their own testing and other factors.  Where I see this having
an impact is more on having the rest of the upstream community keeping
an eye on what the ACPI people are doing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160331/01725641/attachment.sig>
