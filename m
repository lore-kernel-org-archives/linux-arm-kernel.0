From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 18 Nov 2013 00:21:57 +0000
Subject: UEFI Clock
In-Reply-To: <CAPw-ZTnPecp+VYfn5yukrpFNk5sCr5LVDNFty0sLhY=NNhNkXg@mail.gmail.com>
References: <CAPw-ZTnPecp+VYfn5yukrpFNk5sCr5LVDNFty0sLhY=NNhNkXg@mail.gmail
 .com>
Message-ID: <20131118002157.56626C409E3@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 14 Nov 2013 16:01:13 -0800, Loc Ho <lho@apm.com> wrote:
> Hi Mike,
> 
> I will be looking into covering the clock driver to support UEFI.
> Before I do this, can someone explain to me how x86 system handle each
> IP clock as I don't see such thing?

UEFI is completely unrelated to the clock drivers, it is only a firmware
interface for the OS loader. UEFI mostly disappears after Linux is
loaded. Are you perhaps asking about ACPI?

There isn't such a thing on x86. This is entirely new territory. On x86
as far as I know any clock manipulation that does need to be done would
be performed by an ACPI method, but there is no concept of an IP clock
in the ACPI namespace, and so no standard way of describing them.

You'd be much better of talking to Al Stone and Grame Gregory about what
their plans are for clock support in ACPI and to post your question to
the ACPI mailing list.

g.
