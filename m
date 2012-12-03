From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 3 Dec 2012 14:09:56 -0500
Subject: [PATCH v4 09/14] KVM: ARM: Emulation framework and CP15 emulation
In-Reply-To: <20121203110537.GD18579@mudshark.cambridge.arm.com>
References: <20121110154203.2836.46686.stgit@chazy-air>
 <20121110154313.2836.2851.stgit@chazy-air>
 <20121119150105.GB3205@mudshark.cambridge.arm.com>
 <CANM98qKSnt8dmjs9f5ufLPBYAvaSunzKsDTMfi2hm6nLjgjLqg@mail.gmail.com>
 <20121203110537.GD18579@mudshark.cambridge.arm.com>
Message-ID: <CANM98qKnDNknap3EGGcTH-_vhbdDDhNFO1Axx-crr+q3p5i=Uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 3, 2012 at 6:05 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Nov 30, 2012 at 08:22:28PM +0000, Christoffer Dall wrote:
>> On Mon, Nov 19, 2012 at 10:01 AM, Will Deacon <will.deacon@arm.com> wrote:
>> > On Sat, Nov 10, 2012 at 03:43:13PM +0000, Christoffer Dall wrote:
>> > This should probably be 0xff and also use the macros that Lorenzo is
>> > introducing:
>> >
>> >   http://lists.infradead.org/pipermail/linux-arm-kernel/2012-November/132977.html
>> >
>>
>> in the A15 TRM bits [7:2] are reserved, so we really only do care
>> about bits [1:0], and this file is A15 specific, but if you prefer, I
>> can merge this:
>
> The upper bits are RAZ, so yes, please do merge something like this.
>
I did, thanks!
