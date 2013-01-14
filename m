From: will.deacon@arm.com (Will Deacon)
Date: Mon, 14 Jan 2013 22:50:42 +0000
Subject: [PATCH v5 04/12] ARM: KVM: Initial VGIC infrastructure code
In-Reply-To: <CANM98q+y4GoHmqh-CS+fDnfbDbBQHQOY05urer5DMgy9b1X5ng@mail.gmail.com>
References: <20130108184116.46558.3558.stgit@ubuntu>
 <20130108184150.46558.35674.stgit@ubuntu>
 <20130114153107.GE18935@mudshark.cambridge.arm.com>
 <CANM98q+y4GoHmqh-CS+fDnfbDbBQHQOY05urer5DMgy9b1X5ng@mail.gmail.com>
Message-ID: <20130114225042.GC3937@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 09:08:54PM +0000, Christoffer Dall wrote:
> On Mon, Jan 14, 2013 at 10:31 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Tue, Jan 08, 2013 at 06:41:51PM +0000, Christoffer Dall wrote:
> >> +               case ACCESS_READ_VALUE:
> >> +                       *((u32 *)mmio->data) = (regval >> shift) & mask;
> >> +               }
> >> +       }
> >> +}
> >
> > As I mentioned previously, I suspect that this doesn't work with big-endian
> > systems. Whilst that's reasonable for the moment, a comment would be useful
> > for the unlucky soul that decides to do that work in future (or add
> > accessors for mmio->data as I suggested before).
> >
> admittedly this really hurts my brain, but I think there's actually no
> problem with endianness: whatever comes in mmio->data will have native
> endianness and the vgic is always little-endian, so a guest would have
> to make sure to do its own endianness conversion before writing data,
> or did I get this backwards? (some nasty feeling about if the OS is
> compiled in another endianness than the hardware everything may
> break).

No, you're right. As long as the vgic is always little-endian the access
will be ok.

Sorry for the false alarm,

Will
