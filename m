From: brendanhiggins@google.com (Brendan Higgins)
Date: Mon, 12 Feb 2018 18:08:45 -0800
Subject: [PATCH v1 1/2] arm: npcm: add low-level debug support for NPCM7XX
In-Reply-To: <CACPK8XcGhxTq7QGeub2rAEtGSyrOmnobspVJfhE5YmB6MQRM9w@mail.gmail.com>
References: <20180212205833.151019-1-brendanhiggins@google.com>
 <20180212205833.151019-2-brendanhiggins@google.com>
 <CACPK8XcGhxTq7QGeub2rAEtGSyrOmnobspVJfhE5YmB6MQRM9w@mail.gmail.com>
Message-ID: <CAFd5g46EVEQmETawUagDLzySLTFQqc2aM4kFJvvHMU_dvP5V3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 12, 2018 at 5:59 PM, Joel Stanley <joel@jms.id.au> wrote:
> Hi Brendan,
>
> On Tue, Feb 13, 2018 at 7:28 AM, Brendan Higgins
> <brendanhiggins@google.com> wrote:
>> Enable low-level debug support for Nuvoton NPCM7XX family by adding the
>> debug port definitions for the SoC.
>
> When playing with the Poleg boards at the recent OpenBMC hackathon
> Jeremy discovered that the UART is a normal-ish 8250, with a custom
> divisor and a few extra bits to be set.
>
> I found that we can us the generic 8250 low level debugging support
> just fine. This is because u-boot sets up the divisor settings for us
> (as you've assumed with your version here), and from there it's just
> reading/writing characters.
>
> Assuming you can reproduce our results, I suggest we drop these
> patches in favour of adding the correct configuration the Poleg.
>

Sounds good to me. I trust that if you were able to get the 8250 driver
working on the Poleg that it does indeed work.

We can talk about configuring it off the Linux mailing lists.

<snip>

Thanks!
