From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 16 Aug 2013 10:49:30 +0800
Subject: [ARM ATTEND] Trustzone-based security solution for ARM Linux
In-Reply-To: <20130815140817.GA4103@localhost.localdomain>
References: <CAGsJ_4xnivwNW_Pvhv7Jg62a94d5FChwqEwnNX3Miqd5fAxNHA@mail.gmail.com>
 <20130815140817.GA4103@localhost.localdomain>
Message-ID: <CAGsJ_4yM4=SX+mLWu=9UyUfHCuXQy4WmTp9KDa+KNi00zgUgSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[snip]
>
> Needless to say, there are multiple proprietary blobs out there which
> do much what you describe, though these are closed and locked down.
>
yes. i have listed [1][2][3] as examples.
[1]SafeG (Safety Gate): http://www.toppers.jp/en/safeg.html
[2]Green Hills Multivisor:
http://www.ghs.com/products/rtos/integrity_virtualization.html
[3]SierraVisor: http://www.openvirtualization.org/

>
> As others have said, the Secure World is just another execution space,
> so there's no technical reason not to have some FOSS running in there,
> be it an RTOS, uClinux or Linux.
>

non-security world need to know how much time is taken away from
security world whatewer OS security world uses.

> However, the ways in which resources can be shared between the Secure
> World and Normal World are inflexible compared with the kind of sharing
> you get from a normal hypervisor.  The Secure World doesn't have any
> true virtualisation capabilities.
>

except the stolen time issue, actually a high-level msg protocol like
virtio and RPMsg will help rich information sharing between
non-security and security world than a simple SMC call.
these communication channels are not specific to CSR chips, can be
re-used by all SoCs if they have similar scenarios. so i am thinking
whether we can have some generic framework for that in ARM Linux.

>
> The real challenge would be getting sufficiently open hardware, with
> sufficient documentation, and/or finding a friendly hardware vendor who
> can be persuaded of the merits of supporting or investing in an open
> solution.  The rest is "just software".

yes. let's handle the "just software" issues here, leave the hardware
issues to IC guys.

>
> Cheers
> ---Dave
>
-barry
