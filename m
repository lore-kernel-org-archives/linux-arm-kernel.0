From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Sat, 10 Nov 2012 09:36:44 +0100
Subject: [kvmarm] [PATCH v3 01/13] KVM: ARM: Introduce
 KVM_SET_DEVICE_ADDRESS ioctl
In-Reply-To: <1352469079.5117.1.camel@pasglop>
References: <20121022065104.18672.52989.stgit@ubuntu>
 <20121022065122.18672.86203.stgit@ubuntu>
 <CAFEAcA8FkmNhiemrLaWLGA8=dToHgnwJdrmOknffgLE18sULBg@mail.gmail.com>
 <1352469079.5117.1.camel@pasglop>
Message-ID: <CANM98qKw7HBzyf0f-9ufN5paaESdCVhVEBR-x2CO=DoyAcq8Xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 9, 2012 at 2:51 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2012-11-09 at 14:45 +0100, Peter Maydell wrote:
>> On 22 October 2012 08:51, Christoffer Dall
>> <c.dall@virtualopensystems.com> wrote:
>> > +struct kvm_device_address {
>> > +       __u32 id;
>> > +       __u64 addr;
>> > +};
>>
>> Ben suggested that this should either be a 64 bit id or have explicit
>> padding. Other than that I think that our current proposed ABI for
>> ARM irqchips is in line with the discussion we just had at KVM Forum
>> for handling non-x86 in-kernel irqchips [hopefully somebody will
>> write the details of that up...]
>>
>> Ben, do I have that right?
>
> I believe it is :-)
>
good, I'll rev the id to a 64 bit field for the next series (coming shortly)
