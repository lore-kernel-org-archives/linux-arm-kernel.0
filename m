From: pbonzini@redhat.com (Paolo Bonzini)
Date: Wed, 11 Jun 2014 10:16:03 +0200
Subject: [RFC v2] ARM VM System Specification
In-Reply-To: <20140611065412.GA24286@lvm>
References: <20140328184517.GA27219@cbox>
 <CAFEAcA-isiLax0UASTMkedwGXWOaBdR7N1t2o87XYDkj5nt5ig@mail.gmail.com>
 <53973AA8.9020301@codeaurora.org>
 <CAFEAcA8RttCvbOAw-m-W6C-mh1o4hj6nqGMkDbRsSF6ZoQZ7Kg@mail.gmail.com>
 <539754E5.3030408@redhat.com> <53975A0A.8090802@redhat.com>
 <20140611065412.GA24286@lvm>
Message-ID: <53981043.3010300@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il 11/06/2014 08:54, Christoffer Dall ha scritto:
> The problem is that the most common user problem with ARM VMs are that
> they boot the thing, and then get no output.  So we wanted some way to
> make sure we know that the kernel should be able to print to a console.
>
> UEFI does provide DBG2 output, but that's only during boot time service
> (so I'm told), and we need to mandate something that will work  when
> the kernel boots.

Doh, indeed the console is not part of run-time services (so it's not 
even available for earlyprintk).

> If kernels actually do use the UEFI runtime services and have no need
> for direct access to an RTC when runing in a UEFI compliant system, then
> I agree with not specifying the hardware details.

The RTC is not needed for ordinary operation of the kernel and, in the 
current kernel, the EFI RTC driver is only used for IA64.  However, it 
seems to be platform independent.  I'll give it a shot (on x86, since 
that's the only architecture for which I know how to get UEFI firmware).

Paolo
