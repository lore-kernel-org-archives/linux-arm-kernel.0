From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Tue, 19 Nov 2013 00:25:36 +0100
Subject: ACPI vs DT at runtime
In-Reply-To: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
Message-ID: <20131118232536.GF1567@rocoto.smurfnet.nu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

Just in case this thread fails to reach its predicted triple-digits, I
would like to revisit something you mentioned in this original email
and then didn't expand on.

On Thu, Nov 14, 2013 at 05:44:10PM -0800, Olof Johansson wrote:
> The more I start to see early UEFI/ACPI code, the more I am certain
> that we want none of that crap in the kernel. It's making things
> considerably messier, while we're already very busy trying to convert
> everything over and enable DT -- we'll be preempting that effort just
> to add even more boilerplate everywhere and total progress will be
> hurt.
> 
> The server guys really want UEFI for their boot protocols,
> installation managers, etc, etc. That's fine, let them do that, but
> that doesn't mean we need to bring the same APIs all the way into the
> kernel.

There is zero dependency on ACPI in the UEFI support code, or indeed in
UEFI itself. Both runtime services support and stub loader have been
designed hardware-description agnostic.

Are you saying that we should not support the kernel interfaces to UEFI
on ARM*, or are you simply mentioning it in passing because it is the
bit responsible for populating the pointer to the ACPI tables?

/
    Leif
