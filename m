From: robherring2@gmail.com (Rob Herring)
Date: Thu, 20 Mar 2014 08:36:58 -0500
Subject: Forcing DEBUG_UART_{PHYS,
 VIRT} changes when switching between v7 platforms?
In-Reply-To: <CAGVrzcZT+3VuuM9wdLTAu7wtbYTFcwSnMaYE7PcR8Eo4PmTnhg@mail.gmail.com>
References: <CAGVrzcZT+3VuuM9wdLTAu7wtbYTFcwSnMaYE7PcR8Eo4PmTnhg@mail.gmail.com>
Message-ID: <CAL_Jsq+arzCDG+BSUJer6q7Gs71n-8KwUW0pfdDKqgjTQfKEWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 19, 2014 at 6:38 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Hi,
>
> When switching between different Multi v7 platform which all select
> DEBUG_UART_8250, whichever platform managed to set
> DEBUG_UART_{PHYS,VIRT} first will end-up forcing its value to the
> others.
>
> What I am seeing at the moment is for instance enabling BCM_MOBILE
> will set DEBUG_UART_PHYS to 0x3e000000, disabling BCM_MOBILE and now
> enabling MVEBU won't force a new DEBUG_UART_PHYS address to be
> re-computed.
>
> Should we add some sort of specific annotation to the Kconfig symbol
> to force a recalculation of the UART PHYS address?

I've hit this before. I believe the problem is some platforms set the
addresses based on their ARCH_FOO rather than a user selected
FOO_DEBUG_UART option. So on multi-platform kernels with one of these
platforms enabled, you have multiple defaults that are true and may
get FOO's addresses instead of what you have selected.

Rob
