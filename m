From: stefan@agner.ch (Stefan Agner)
Date: Wed, 24 Sep 2014 18:33:03 +0200
Subject: [PATCH 5/9] gpio: vf610: Extend with wakeup support
In-Reply-To: <CACRpkdYCiKzyVpg9u-YXn-QMd7PSKR72siXQQWALe0OqTNr-rw@mail.gmail.com>
References: <cover.1411404079.git.stefan@agner.ch>
 <704b6bb97147b3d0ee1557b43d85ab9376c28666.1411404079.git.stefan@agner.ch>
 <CACRpkdYCiKzyVpg9u-YXn-QMd7PSKR72siXQQWALe0OqTNr-rw@mail.gmail.com>
Message-ID: <0a182a1652d0271cdd0a262bc9efc945@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 2014-09-24 11:19, schrieb Linus Walleij:
> On Mon, Sep 22, 2014 at 7:09 PM, Stefan Agner <stefan@agner.ch> wrote:
> 
>> Support Vybrid GPIO's as wakeup source by requesting the parent
>> IRQ as wakeup IRQ.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  drivers/gpio/gpio-vf610.c | 16 ++++++++++++++++
> 
> This driver is not yet upstream. Make wakeup support part
> of the initial driver submission instead, it doesn't hurt.

Ok, will do. 

Just realized that this patch even leads to compile errors when applying
on top of v2 of the GPIO driver; we need the irq in drivers struct here,
and I removed that in v2...  :-)

--
Stefan
