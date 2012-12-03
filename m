From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 3 Dec 2012 09:54:12 -0500
Subject: [PATCH v4 07/13] ARM: KVM: VGIC virtual CPU interface management
In-Reply-To: <50BCB2F7.7010303@arm.com>
References: <20121110154358.3061.16338.stgit@chazy-air>
 <20121110154504.3061.23122.stgit@chazy-air>
 <20121203132337.GC20074@mudshark.cambridge.arm.com>
 <50BCB2F7.7010303@arm.com>
Message-ID: <CANM98qLTKrcmqVhhDy5pEWJmEpScRMo=ekGFu9LUFe9YYgvj9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

>
>>> +
>>> +                       clear_bit(c, &sources);
>>> +               }
>>> +
>>> +               if (!sources)
>>> +                       clear_bit(i, pending);
>>
>> What does this signify and how does it happen? An SGI without a source
>> sounds pretty weird...
>
> See the clear_bit() just above. Once all the sources for this SGI are
> cleared, we can make the interrupt not pending anymore.
>

every time I read the code, I get completely bogged up on trying to
understand this case and I tell myself we should put a comment here,
then I understand why it happens and I think, oh it's obvious, no
comment needed, but now I (almost) forgot again. Could we add a
comment?

-Christoffer
