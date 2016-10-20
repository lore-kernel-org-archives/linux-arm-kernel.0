From: gottfried.haider@gmail.com (Gottfried Haider)
Date: Thu, 20 Oct 2016 18:58:36 +0200
Subject: [PATCH v2] ARM: bcm2835: Add names for the Raspberry Pi GPIO lines
In-Reply-To: <CACRpkdb++5Xb6a=0Zz5eZURNmrkfVyvsBR-pLK9iRiyTu1g8Rw@mail.gmail.com>
References: <CAPoCmYJC1TebBrspD_=mTETULSjg9or5a0Yda8p945y6ZWL99Q@mail.gmail.com>
 <CACRpkdb++5Xb6a=0Zz5eZURNmrkfVyvsBR-pLK9iRiyTu1g8Rw@mail.gmail.com>
Message-ID: <CAPoCmYKrUBEdyNXt8yRMFq_aCmb8WyK-x4a7og66zfeFYX4rQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The old sysfs interface is not changing. However it is deprecated so once
> you have a v4.8+ kernel, consider migrating whatever userspace you have
> to use the chardev ABI instead.
>
> See:
> commit fe95046e960b4b76e73dc1486955d93f47276134
> "gpio: ABI: mark the sysfs ABI as obsolete"
> commit 521a2ad6f862a28e2e43cb3e254a26bf0f9452e9
> "gpio: add userspace ABI for GPIO line information"
> commit d7c51b47ac11e66f547b55640405c1c474642d72
> "gpio: userspace ABI for reading/writing GPIO lines"
> commit 61f922db72216b00386581c851db9c9095961522
> "gpio: userspace ABI for reading GPIO line events"

Thanks for those pointers. Somewhat off topic: is it planned to add
support for setting GENERIC_PINCONF style pull-up/pull-down resistors
throigh the new ABI? (The bcm28xx drivers would still need to
converted to this as well.)


>> Regarding the proposed format using the header pin numbers: From what I've
>> seen in terms of existing educational materials, it seems the overwhelming
>> majority ends up using GPIO numbers instead of physical pin header
>> numbering. (e.g. [1] [2])
>
> What does that number mean? If you are referring to the global
> GPIO numberspace it is obsolete and just reflecting the fact that
> people up until now was referring to Linux-internal GPIO numbers.

I am referring to the name of the various GPIO lines as per datasheet
("GPIO0", "GPIO1", ...). So far, I believe those matched the global
GPIO numberspace.


>> Would it be too confusing to try to pick GPIO 5 from an alphabetically
>> sorted list like this "P11_GPIO17", "P12_GPIO18"? (I know, alphabetical
>> sorting is an issue here already for a different reason. But applications
>> might do it, I guess?)
>
> Any attempt to preserve the global GPIO numberspace is futile.
> If it is the local offset number on the chip it is another thing, that
> is kind of OK if the arch maintainer likes it.

I understand that Linux can't guarantee a certain global GPIO number -
but I fear that the board manufacturers also might not think of the
pin headers as something set in stone (that the can't rearrange in a
future revision/product).

Would there be a reason against _naming_ the pin "GPIO0"? (even if it
ends up with a different global, internal number)


Thanks & best
Gottfried
