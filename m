From: cd2436@columbia.edu (Christoffer Dall)
Date: Wed, 16 Dec 2009 20:25:29 -0500
Subject: Early pl011 console for debugging KVM for ARM port
Message-ID: <7d08b87d0912161725h424dc1c3s3c219f7138d61208@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone.

I am working on a port of KVM for arm (http://android.chazy.dk) and I
am somewhat stuck. I encounter a crash somewhere in do_initcalls(),
but I do not have console at this point, as my only console is the
pl011 uart device. Not having the console makes it quite hard to track
down the bugs (an effort I do by placing asm("swi 0xMAGIC") at various
locations) for now.

Does anyone know how to enable such a console earlier? I tried simply
calling pl011_init() before the initcalls loop, but I eventually hit a
NULL pointer exception inside
list_add_tail(&kobj->entry,&kobj->kset->list); called from
kobject_add(...) in lib/kobject.c. I can gather it's the
kobj->kset->list.prev, which is NULL.

As far as I understand, these structures should have been initialized
at this point. Can anyone confirm?

Any help is greatly appreciated!


Thanks,
Christoffer Dall
