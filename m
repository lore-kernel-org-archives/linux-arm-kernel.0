From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 25 Feb 2016 15:56:48 +0200
Subject: [PATCH 11/11] ARM: versatile: move CLCD configuration to device
 tree
In-Reply-To: <CACRpkdZ=PR6O28NQusUEipCYwRZyuhbeAJO_ZK80+4H7Zakt=g@mail.gmail.com>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
 <CACRpkdbnLgVsrSAu87wxSwktK3ftJzbQLXjU8y65tq=9Ynxicw@mail.gmail.com>
 <56CC2D39.80909@ti.com>
 <CAFEAcA9U3V04o2_93bS5G7+k=UT7kTWt4=v7t1Ju0X9W=5oo9A@mail.gmail.com>
 <56CC546A.9070705@ti.com> <20160224104638.GL19428@n2100.arm.linux.org.uk>
 <56CD924F.50108@ti.com> <B8A82546-46C7-4A21-92D8-62418E49FBB6@konsulko.com>
 <CACRpkdZ=PR6O28NQusUEipCYwRZyuhbeAJO_ZK80+4H7Zakt=g@mail.gmail.com>
Message-ID: <56CF0820.1010602@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/02/16 15:43, Linus Walleij wrote:
> On Wed, Feb 24, 2016 at 1:13 PM, Pantelis Antoniou
> <pantelis.antoniou@konsulko.com> wrote:
> 
>> IMHO DT+overlays handle all your cases just fine.
>>
>> As far as I see these are the cases which we need to handle:
>>
>> 1) The expansion board in question has some means of identification, whether it?s an
>> EEPROM or a GPIO keying combination etc. In that case it is the kernel?s job to match this
>> id value with a dtbo firmware file and apply it. The blob is located via means of request_firmware().
> 
> Since the dawn of time the x86 people used that console to display
> the early boot crawl and collect crash data. What you're suggesting
> is that we can't get the console up until after the filesystems and mounts
> are up so the kernel can read firmware files.

You can build firmware images into the kernel image. No, I don't like
that either.

The 2.2) option in Pantelis' mail can be used for 1) too, although then
the bootloader needs to know which dtbos to add.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160225/35dfa506/attachment.sig>
