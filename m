From: miguel.ojeda.sandonis@gmail.com (Miguel Ojeda)
Date: Fri, 5 Oct 2018 10:52:09 +0200
Subject: [PATCH v2] mm: Introduce new function vm_insert_kmem_page
In-Reply-To: <CAFqt6zaFc_GenhfvsD0VPfepR-jjXypj+4CgNEuHMVq1WXV+8w@mail.gmail.com>
References: <20181003185854.GA1174@jordon-HP-15-Notebook-PC>
 <20181003200003.GA9965@bombadil.infradead.org>
 <20181003221444.GZ30658@n2100.armlinux.org.uk>
 <CAFqt6zYHhmPwUdaCZX-BuAvaVwA-x1W39tz+Q50-nbEaW2cYVg@mail.gmail.com>
 <20181004123400.GC30658@n2100.armlinux.org.uk>
 <CAFqt6zZPOM17QwmcWKF3F1gqkJm=2PxvuJ3naWuRXZGHc2HrEQ@mail.gmail.com>
 <20181004181736.GB20842@bombadil.infradead.org>
 <CAFqt6zaN0PQHkjuwFf8VriROLy7qrPDu-iNE=VPiXJw8C7GpQg@mail.gmail.com>
 <CANiq72mkTP_m20vqei-cpN+ypQ_gU472qn5m68vb_4Nqj5afMQ@mail.gmail.com>
 <CAFqt6zaFc_GenhfvsD0VPfepR-jjXypj+4CgNEuHMVq1WXV+8w@mail.gmail.com>
Message-ID: <CANiq72kVJn7985EET067Dgj+z0dwb0x2MTUnREMWKCVU6=WnJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Souptick,

On Fri, Oct 5, 2018 at 7:51 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Fri, Oct 5, 2018 at 1:16 AM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> >
> > Also, not sure if you saw my comments/review: if the interface is not
> > going to change, why the name change? Why can't we simply keep using
> > vm_insert_page?
>
> yes, changing the name without changing the interface is a
> bad approach and this can't be taken. As Matthew mentioned,
> "vm_insert_range() which takes an array of struct page pointers.
> That fits the majority of remaining users" would be a better approach
> to fit this use case.
>
> But yes, we can't keep vm_insert_page and vmf_insert_page together
> as it doesn't guarantee  that future drivers will not use vm_insert_page
> in #PF context ( which will generate new errno to VM_FAULT_CODE).
>

Maybe I am hard of thinking, but aren't you planning to remove
vm_insert_page with these changes? If yes, why you can't use the keep
vm_insert_page name? In other words, keep returning what the drivers
expect?

Cheers,
Miguel
