From: pbonzini@redhat.com (Paolo Bonzini)
Date: Tue, 10 Jun 2014 19:00:28 +0200
Subject: [RFC v2] ARM VM System Specification
In-Reply-To: <CAFEAcA-isiLax0UASTMkedwGXWOaBdR7N1t2o87XYDkj5nt5ig@mail.gmail.com>
References: <20140328184517.GA27219@cbox>
 <CAFEAcA-isiLax0UASTMkedwGXWOaBdR7N1t2o87XYDkj5nt5ig@mail.gmail.com>
Message-ID: <539739AC.3030800@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il 10/06/2014 16:42, Peter Maydell ha scritto:
>  The guest OS must include support for pl031 and mc146818 RTC.
>
> (QEMU is going to provide a PL031, because that's the standard
> ARM primecell device for this and it's what's in the vexpress.
> kvmtool looks like it's going to provide mc146818, because
> that's the standard x86 RTC and kvmtool happens to already
> emulate that.)

Why can't kvmtool add pl031 support?  mc146818 is quite complicated to 
emulate efficiently (without waking up once a second or more).

Paolo
