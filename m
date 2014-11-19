From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 19 Nov 2014 16:55:17 +0000
Subject: [PATCH RFC] ARM: option for loading modules into vmalloc area
In-Reply-To: <CAKv+Gu8o_-Q5PeFqdQXW=mcHNYxFcLLnvxjq94y-iG8+JUp=9w@mail.gmail.com>
References: <20141118173413.GB4042@n2100.arm.linux.org.uk>
 <546B8C64.3010904@samsung.com> <2041617.Kxhx5O4MMr@wuerfel>
 <CAKv+Gu-8qhHYOry+LsDzp+LDZqYxVZ5G7cj48E3G2Unp2+=_yg@mail.gmail.com>
 <CALYGNiMt2A3DP02cOtxqu4RrnmhojrDxkRG7bkHMByUnzG+PeA@mail.gmail.com>
 <CAKv+Gu-rYWutr-45MsZH6KOhhUyNCVLfkO9JQrqCm1L6ms_DUg@mail.gmail.com>
 <20141119160747.GH4042@n2100.arm.linux.org.uk>
 <CAKv+Gu-kvmkhrptmaN0miM3c0K3ZOh4maTFXL=NpYTMi9Q83kA@mail.gmail.com>
 <CALYGNiN5XC_4MhRbxZmFW5Jmc1N1H32tSZr3kKf_UBFriG71nA@mail.gmail.com>
 <CAKv+Gu8o_-Q5PeFqdQXW=mcHNYxFcLLnvxjq94y-iG8+JUp=9w@mail.gmail.com>
Message-ID: <20141119165517.GL4042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 19, 2014 at 05:38:57PM +0100, Ard Biesheuvel wrote:
> Numbers are disambiguated by the f and b suffixes, so they can be
> reused in the same .s file. So as long as you use a strictly numerical
> prefix, you can deal correctly with the case where, for instance,
> do_div() is called twice in the same compilation unit, and still not
> clash with other inline asm

What's not particularly nice though is to hide these in a macro,
which itself may be part of a larger macro or code fragment also
using small numbers.

We probably ought to be a bit more inteligent about how we choose
these numbers inside macros, rather than just randomly picking some
and hoping that they don't clash.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
