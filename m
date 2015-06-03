From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Tue, 2 Jun 2015 21:13:19 -0700
Subject: [PATCH 0/3] GPIO support for BRCMSTB
In-Reply-To: <CACRpkdY_-zq-1srBC213MK_RoVvPsfTpRTQyx-4yRvCOV5JdxQ@mail.gmail.com>
References: <1430901477-10678-1-git-send-email-gregory.0xf0@gmail.com>
 <CACRpkda3EDa7YdzeT6FQ=cQw1RrDath7pQsCos-JeB2y4r18gw@mail.gmail.com>
 <CADtm3G45-u82Rp_0dHf2EfdMokf8E4FaQ84PHnocpvXxU+5_+g@mail.gmail.com>
 <CACRpkdaTYAr-7K5_QZh1CyeyA1224obqEB2Sz8UHZmrWcfv+ow@mail.gmail.com>
 <CADtm3G4ao=3sHx2F1+V9rwS=jWf6ZdEQi4d24HxQ6MEc+CQ8CQ@mail.gmail.com>
 <CACRpkdY_-zq-1srBC213MK_RoVvPsfTpRTQyx-4yRvCOV5JdxQ@mail.gmail.com>
Message-ID: <CADtm3G7mKJ6b9Koy0DeTAVUeJyhS9Lw+AzEvKf-xmFXTmAuG2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 2, 2015 at 2:05 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, May 27, 2015 at 5:26 AM, Gregory Fong <gregory.0xf0@gmail.com> wrote:
>> I've now actually attempted to use the gpiolib irqchip code.  This
>> driver can't directly use gpiochip_irqchip_add() because of the
>> multiple gpiochip : one irqchip map.  At first, I thought it might be
>> possible to simply add a new argument (or break things into a helper
>> function) to allow setting the associated IRQ domain, but then I can't
>> use the generic map and unmap functions which expect the irq_domain
>> host_data member to be struct gpiochip *, which makes no sense in this
>> case.  That puts me right back to implementing a special version of
>> the map and unmap function.
>
> I see.
>

I think I was wrong, it isn't actually necessary to have a single
irq_chip as long as all of the IRQs use the same handler.  I have a
preliminary implementation doing that instead that seems to work fine.
Once I've had a chance to verify that it works in all cases, will post
that as v3.

Cheers,
Gregory
