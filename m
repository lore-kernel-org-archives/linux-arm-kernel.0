From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 13 Mar 2013 16:02:15 +0530
Subject: PL330 interrupt handling
In-Reply-To: <CAOcd1mo4ZQSzZ_RYPm__kVr1ygmvG3LYGmabrfb=MALvk0P=5w@mail.gmail.com>
References: <CAOcd1mrL219kP-SLcjxQ2x79A-LvwxXjesv3G9Y=R+w5=Rjtsw@mail.gmail.com>
 <CABb+yY1EqszSFhnbWve2yEpmcgMdofM5uFJSCe1b4he0-LnGQA@mail.gmail.com>
 <CAOcd1mo4ZQSzZ_RYPm__kVr1ygmvG3LYGmabrfb=MALvk0P=5w@mail.gmail.com>
Message-ID: <CABb+yY1ppU8wPn3V95tJYhB7ERqnzoAsXXJFSW7SeaMQhgy3tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 13, 2013 at 3:45 PM, Naveen Mamindlapalli
<naveen.mamindlapalli@gmail.com> wrote:
> Hi Jassi,
>
> Thanks for the reply.
> I am not aware of the advantages with such configuration. Is there any
> documentation (other than TRM) that explains about how to configure PL330,
> especially interrupts?
>
Configuration is decided at design time of the controller. You can
only read the configuration from the driver.
For you, if pl330.c works with more than one dma client at a time,
your h/w setup is same as others and you need not worry.

> I have one more question regarding alignment:
> It seems to me that this driver doesn't take care of source/destination
> address alignment restrictions. Is this the application driver
> responsibility to handle the alignment issues?
>
Yes.
