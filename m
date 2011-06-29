From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 29 Jun 2011 15:29:23 +0300
Subject: [RFC 7/8] drivers: introduce rpmsg,
	a remote-processor messaging bus
In-Reply-To: <201106291359.14026.arnd@arndb.de>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<20110628164453.aa85c85c.rdunlap@xenotime.net>
	<BANLkTinDX9ETcqZ=hvSGaao2s=ZcM-JsAg@mail.gmail.com>
	<201106291359.14026.arnd@arndb.de>
Message-ID: <BANLkTiki0fZuVB4it1mOVbEYVZ8tUx0BTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2011 at 2:59 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 29 June 2011, Ohad Ben-Cohen wrote:
>> On Wed, Jun 29, 2011 at 2:44 AM, Randy Dunlap <rdunlap@xenotime.net> wrote:
>> >> +hardware accelerators, and therefore are often used to offload cpu-intensive
>> >
>> > prefer: ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? CPU-
>> > throughout.
>>
>> Isn't that changing the meaning a bit ? Let's stick with the original
>> version, I think it's more clear.
>
> I think you misunderstood Randy, he meant you should do 's/cpu/CPU/' globally,

Oh, sorry, Randy. For some reason I thought you meant
s/cpu-intensive/CPU-throughout/ which didn't make a lot of sense to me
:)

s/cpu/CPU/ is of course nicer. thanks !

> The easiest way would be to replace it with 'or', as in
>
> ... remote cores (or hardware accelerators) may have ...

yeah, i'll do it, thanks.

It's a bit harder to get rid of the parentheses in the second
sentence, but I'll think of something too.

>> Probably the solution is to move 'source "drivers/virtio/Kconfig"'
>> into drivers/Kconfig, and remove all other instances.
>
> I think changing that would be good. However, you need to at least
> restructure the contents, or they will show up in the main driver menu.

I'll do that.

Thanks,
Ohad.
