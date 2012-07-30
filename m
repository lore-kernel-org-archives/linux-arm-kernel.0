From: svenkatr@ti.com (S, Venkatraman)
Date: Mon, 30 Jul 2012 20:16:47 +0530
Subject: rmk back but still recovering (was Re: Reminder - rmk still on
 vacation)
In-Reply-To: <20120730144443.GG7405@n2100.arm.linux.org.uk>
References: <20120725141222.GA6939@n2100.arm.linux.org.uk>
 <20120727134231.GA5934@n2100.arm.linux.org.uk>
 <CAMQu2gzrG2qC3_YXjaxQnc+2WzsiqoyMeOMScEWWR+gR2Vc0cw@mail.gmail.com>
 <20120727165049.GB7405@n2100.arm.linux.org.uk>
 <CAMQu2gyTgkswS1tYY=0g1oF7u=RGdQKEw0C3m3r3Jr+j_k9dsQ@mail.gmail.com>
 <CANfBPZ_qzXgm0bX8XDnKLwoYTtcARPj+8MHpsSEWy0=G5f9qAA@mail.gmail.com>
 <CAMQu2gzAcJBCxC5VtmyUOPMhc7D5P_MKCczdrxdeR0GNqMFYUg@mail.gmail.com>
 <20120730143323.GE7405@n2100.arm.linux.org.uk>
 <CAMQu2gyxODJb2Kc_AtYPrhwoOvEwQNLkYHvbk3e=UPdgvxdWng@mail.gmail.com>
 <20120730144443.GG7405@n2100.arm.linux.org.uk>
Message-ID: <CANfBPZ9H9D-HGu2YT5hp-OXPqY4M6BZcH2qhUfHO203RokZ0Aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 8:14 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jul 30, 2012 at 04:37:09PM +0200, Shilimkar, Santosh wrote:
>> On Mon, Jul 30, 2012 at 4:33 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > So I take that as you wanting exactly what is in linux-next merged without
>> > any further changes?
>>
>> Just one patch[1] on top of that so that default omap2plus_defconfig
>> keeps working.
>
> Err, I don't see what that patch does.  Setting ret=-ENXIO at the
> start of the function, when it's subsequently overwritten by:
>
> +       int ret = -ENXIO, irq;
> ...
>         ret = omap_hsmmc_gpio_init(pdata);
> ...
>         ... dma stuff ...
>
> seems absurd.

I think Santosh meant this patch..
http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap.git;a=commitdiff;h=55936cdfaaf11ac352b56bc58e42d6661e65ee13
