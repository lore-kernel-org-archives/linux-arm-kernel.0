From: miguel.ojeda.sandonis@gmail.com (Miguel Ojeda)
Date: Fri, 5 Oct 2018 20:09:03 +0200
Subject: [PATCH v2] mm: Introduce new function vm_insert_kmem_page
In-Reply-To: <CAFqt6zYH4Aczu8AYke8AfGuMS70SJXCMn-n8X8C_Tz03gTjn8g@mail.gmail.com>
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
 <CANiq72kVJn7985EET067Dgj+z0dwb0x2MTUnREMWKCVU6=WnJA@mail.gmail.com>
 <CAFqt6zZ4sPjtb5BaDfwc5tZv+vMj6ao3NJZ_3quX9AH5pCMwJg@mail.gmail.com>
 <CANiq72m9u1PL9X+dPNLxgkhvttj=4ijLyM2sFex=Kws7wswKzw@mail.gmail.com>
 <CAFqt6zYH4Aczu8AYke8AfGuMS70SJXCMn-n8X8C_Tz03gTjn8g@mail.gmail.com>
Message-ID: <CANiq72kRAZE9SyM4EkpaBZH03Ex0Z=4Pk2iOuc2jBDKTfKjHQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 5, 2018 at 2:11 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Fri, Oct 5, 2018 at 4:19 PM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> >   1. Introduce the vmf_* API
> >   2. Change all PF-users users to that (leaving all non-PF ones
> > untouched!) -- if this is too big, you can split this patch into
> > several patches, one per subsystem, etc.
>
> We are done with step 2. All the PF-users are converted to use
> vmf_insert_page. ( Ref - linux-next-20181005)

They are not supposed to be "steps". You did it with 70+ commits (!!)
over the course of several months. Why a tree wasn't created, stuff
developed there, and when done, submitted it for review?

> >
> > Otherwise, if you want to pursue Matthew's idea:
> >
> >   4. Introduce the vm_insert_range (possibly leveraging
> > vm_insert_page, or not; you have to see what is best).
> >   5. Replace those callers that can take advantage of vm_insert_range
> >   6. Remove vm_insert_page and replace callers with vm_insert_range
> > (only if it is not worth to keep vm_insert_range, again justifying it
> > *on its own merits*)
>
> Step 4 to 6, going to do it.  It is part of plan now :-)
>

Fine, but you haven't answered to the other parts of my email: you
don't explain why you choose one alternative over the others, you
simply keep changing the approach.

Cheers,
Miguel
