From: will.deacon@arm.com (Will Deacon)
Date: Fri, 2 Aug 2013 11:11:52 +0100
Subject: AArch64 arch_spin_unlock not signaling global event?
In-Reply-To: <CANz0V+5qHD-xX7LyAd5nVWsdP00Rys5MzasKrnSzbMhmC=mskw@mail.gmail.com>
References: <CANz0V+6-yk9jWZ1y9zidKFJAhDof9qQR1uAHzsvhwswApMbxUA@mail.gmail.com>
 <20130801084835.GA12077@mudshark.cambridge.arm.com>
 <CANz0V+5qHD-xX7LyAd5nVWsdP00Rys5MzasKrnSzbMhmC=mskw@mail.gmail.com>
Message-ID: <20130802101151.GK2465@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 01, 2013 at 11:23:55AM +0100, Andrei E. Warkentin wrote:
> 2013/8/1 Will Deacon <will.deacon@arm.com>:
> > On Wed, Jul 31, 2013 at 09:19:13PM +0100, Andrei E. Warkentin wrote:
> >> Shouldn't that be followed by a 'sev'?
> >
> > No. In ARMv8, When the exclusive is cleared for a processor, an event is
> > generated.
> >
> 
> But 'stlr' doesn't appear to be an exclusive instruction. It's filed
> under 5.2.8.1 - Non-exclusive load-acquire/store-release in the ISA
> doc.

That doesn't matter -- any write will clear the monitor state for that
location.

`Any successful write to the tagged address by any other observer in the
 shareability domain of the memory location is guaranteed to clear the tag.'

Please read section 3.4. "Synchronization and semaphores" of the ARM ARM.

> The Foundation_v8 sim behavior seems to confirm that as well.

If that's true, please can you report a bug against the model?

Cheers,

Will
