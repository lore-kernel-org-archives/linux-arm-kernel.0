From: drake@endlessm.com (Daniel Drake)
Date: Wed, 23 Jul 2014 07:30:33 +0100
Subject: [PATCH 0/3] Deterministic UART numbering on Samsung SoCs
In-Reply-To: <20140709142333.503a9e39@alan.etchedpixels.co.uk>
References: <1403781875-5425-1-git-send-email-t.figa@samsung.com>
 <20140626113939.GP32514@n2100.arm.linux.org.uk>
 <53AC0BCC.1010608@samsung.com>
 <CAD8Lp45MvDLsxehayx8uuGt3w3O0vGskiFjb1vdvtOyOv2nG2w@mail.gmail.com>
 <20140709142333.503a9e39@alan.etchedpixels.co.uk>
Message-ID: <CAD8Lp47GpiRabx56u5F+qrY=mx_OOj2dOqfQ6_=4TBe=JskDkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 9, 2014 at 2:23 PM, One Thousand Gnomes
<gnomes@lxorguk.ukuu.org.uk> wrote:
>> I like the sound of going to the standard ttyS notation and only
>> providing ports for ones that exist, but is this userspace-visible
>
> ttyS is 8250 compatible UARTS.
>
> If the Samsung is not an 8250 compatible UART then it doesn't belong as
> ttyS from the kernel perspective.

OK, thanks for pointing that out.

So we stick with the ttySAC namespace. And by doing that, and sticking
to the existing and documented behaviour, it seems like we have
already addressed Russells's concern:

> The problem you're raising is very much the same problem you have when
> there are multiple USB serial devices connected to the machine - you
> just get a bunch of /dev/ttyUSB* devices which are unordered (they can
> change on each boot, or change order if you disconnect and reconnect
> them.)

In this case, we have a dedicated namespace and the path information
is already fully encoded in the device name. The order and number of
ports are fixed, they can't be disconnected and reconnected. There is
no real risk of an additional serial controller driver coming to play
in the ttySAC namespace.

So I think Tomasz's approach is good - although I haven't looked at
the code in detail.

Thanks
Daniel
