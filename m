From: jcm@redhat.com (Jon Masters)
Date: Wed, 26 Apr 2017 00:17:08 -0400
Subject: [PATCH] PCI/MSI: pci-xgene-msi: Enable MSI support in ACPI boot
 for X-Gene v1
In-Reply-To: <CADaLNDkvY_gZwWYfy1dHzBLRwH1S1h3gTN9ib5ixqG4REJuOow@mail.gmail.com>
References: <1455069384-22323-1-git-send-email-dhdang@apm.com>
 <1456330151.5681.46.camel@redhat.com> <56CDD767.6020103@arm.com>
 <CADaLND=mrkxOWOzcEb8os16Rb=SDHfnn_8eSgB4bQYH3UguS3w@mail.gmail.com>
 <20160225173822.GA6349@red-moon>
 <CADaLNDnywVPER9QhmK4C6JyCLhta_M_cVSOuSkEHnmnLPFo3JA@mail.gmail.com>
 <20160526123459.GA23794@red-moon>
 <CADaLNDnf8SRbUkBN9fZMvrvsnTQs+DLyqnZfVpWqVyyY8Hk=1Q@mail.gmail.com>
 <20160527105238.GA25842@red-moon>
 <CADaLNDkvY_gZwWYfy1dHzBLRwH1S1h3gTN9ib5ixqG4REJuOow@mail.gmail.com>
Message-ID: <6b577a0e-db39-d2d9-1093-3fb2513c568f@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/2016 06:15 PM, Duc Dang wrote:

> Do you have other suggestions? Otherwise, I will prepare a patch
> following Lorenzo's approach.

Duc has since left Applied for other pastures. I miss him, he's a great
guy. He laid all the right groundwork for this, but the ACPI binding
still needs to be upstreamed. It's a few lines of code matching on
APMC0D0E but without it, upstream kernels wont have working MSI on
X-Gene with ACPI. I need this to be upstreamed soon please :) Can
someone at APM followup with an updated patch, and get it in?

Here's the rub. The average person booting a Linux box (even a good
kernel person) isn't going to say "hey, MSIs aren't setup right on this
ARM server because it's compliant with 1 out of 3 possible ways MSIs
might be done at a high level [let's forget the many others] and all it
needs is this...". What they're going to say is "huh, PCIe card doesn't
work, might be an MSI problem". Which is the email I have after someone
tried using an IB card in an X-Gene box and spent a few hours poking.

We're so close to having "ACPI all the things" but the latest
development builds of RHEL don't do MSI on X-Gene because of the Red Hat
"upstream first" rules. So let's get that fixed.

Thanks,

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop
