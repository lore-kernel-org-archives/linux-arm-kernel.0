From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 27 Sep 2012 15:45:50 +0100
Subject: [kvmarm] [PATCH 06/15] KVM: ARM: Initial skeleton to compile KVM
 support
In-Reply-To: <20120927141314.GK25916@mudshark.cambridge.arm.com>
References: <20120915153359.21241.86002.stgit@ubuntu>
 <20120915153508.21241.47712.stgit@ubuntu>
 <20120925152055.GC28728@mudshark.cambridge.arm.com>
 <50625DB2.4000700@virtualopensystems.com>
 <20120927141314.GK25916@mudshark.cambridge.arm.com>
Message-ID: <CAFEAcA-3hcteG2pOLh3ZtRF+uw-X2LS+zkAp2tq7BT4SkYqtaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 September 2012 15:13, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, Sep 26, 2012 at 02:43:14AM +0100, Christoffer Dall wrote:
>> this API has been discussed to death on the KVM lists, and we can of
>> course revive that if the regset makes it nicer - I'd prefer getting
>> this upstream the way that it is now though, where GET_REG / SET_REG
>> seems to be the way forward from a KVM perspective.
>
> I'm sure the API has been discussed, but I've not seen that conversation and
> I'm also not aware about whether or not regsets were considered as a
> possibility for this stuff.

Can you point me at some documentation for regsets? It's a bit
difficult to have a sensible conversation about their suitability
otherwise...

(The potentially tricky area to handle is the cp15 registers, where
it's quite likely that new registers might be added later and so
userspace has to be able to query the kernel for what is supported
and possibly deal with the kernel reporting attempts to set read
only bits within registers, etc. Using the same ABI for simpler
cases like the GPRs and FP registers is then just a matter of
being consistent in the interface we expose to userspace.)

-- PMM
