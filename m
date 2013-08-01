From: andrey.warkentin@gmail.com (Andrei E. Warkentin)
Date: Thu, 1 Aug 2013 06:23:55 -0400
Subject: AArch64 arch_spin_unlock not signaling global event?
In-Reply-To: <20130801084835.GA12077@mudshark.cambridge.arm.com>
References: <CANz0V+6-yk9jWZ1y9zidKFJAhDof9qQR1uAHzsvhwswApMbxUA@mail.gmail.com>
 <20130801084835.GA12077@mudshark.cambridge.arm.com>
Message-ID: <CANz0V+5qHD-xX7LyAd5nVWsdP00Rys5MzasKrnSzbMhmC=mskw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/8/1 Will Deacon <will.deacon@arm.com>:
> On Wed, Jul 31, 2013 at 09:19:13PM +0100, Andrei E. Warkentin wrote:
>> Hiya,
>>
>> I've noticed the AArch64 arch_spin_unlock is implemented with the
>> 'stlr' instruction.
>>
>> Shouldn't that be followed by a 'sev'?
>
> No. In ARMv8, When the exclusive is cleared for a processor, an event is
> generated.
>
> Will

But 'stlr' doesn't appear to be an exclusive instruction. It's filed
under 5.2.8.1 - Non-exclusive load-acquire/store-release in the ISA
doc.

The Foundation_v8 sim behavior seems to confirm that as well.

-- 
A
