From: neko@bakuhatsu.net (Matt Sealey)
Date: Thu, 16 Apr 2015 17:03:12 -0500
Subject: [RFC PATCH 0/5] Add smp booting support for Qualcomm ARMv8 SoCs
In-Reply-To: <CAF6AEGt3bf70MUWFU_kqtc8KDR09tMUCkXbqOq0SpOXU44moTg@mail.gmail.com>
References: <1428601031-5366-1-git-send-email-galak@codeaurora.org>
 <20150410100529.GA6854@e104818-lin.cambridge.arm.com>
 <20150414163613.GM28709@leverpostej>
 <07185B2C-3F37-4E70-9096-1EF5EA8D68CE@codeaurora.org>
 <20150414211720.GA56647@MBP>
 <CAF6AEGtoxNrCoxT5n0CXmKMnL-YprJ3DkAuM4Myi87WMxPqBGw@mail.gmail.com>
 <20150415133403.GB26099@e104818-lin.cambridge.arm.com>
 <CAF6AEGucYT4LHkFggR0fO_c7gZe7hD7STx1xwKrOvwsnnFbw7Q@mail.gmail.com>
 <20150416152121.GE819@e104818-lin.cambridge.arm.com>
 <CAF6AEGt3bf70MUWFU_kqtc8KDR09tMUCkXbqOq0SpOXU44moTg@mail.gmail.com>
Message-ID: <CAHCPf3uf+VP5NuEnwABQefeLLm07xb1gwa-tNvLGug1j=Wi-Jg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Thu, Apr 16, 2015 at 12:17 PM, Rob Clark <robdclark@gmail.com> wrote:
> On Thu, Apr 16, 2015 at 11:21 AM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
>
>> But I'm definitely going to discourage companies like Qualcomm
>> deliberately ignoring the existing booting protocols while trying to get
>> their code upstream. This patch series is posted by Qualcomm without
>> providing any technical reason on why they don't want to/couldn't use
>> PSCI (well, I guess there is no technical reason but they may not care
>> much about mainline either).
>
> Sure.. just trying to make sure the wrong people don't end up being
> the ones that suffer.  I would assume/expect that it is at least
> possible for qcom to change firmware/bootloader for their dev boards
> and future devices and whatnot, whether they grumble about it or not.
> But I guess most of what the general public has are devices w/ signed
> fw, which is why "go fix your firmware" is an option that sets off
> alarm bells for me.
>
> I guess the first device where this will matter to me and a large
> group of community folks would be the dragonboard 410c..  *hopefully*
> it does not require signed firmware or at least qcom could make
> available signed firmware which supports psci..

For development boards, one would hope there is a way to sign your own firmware.
You can't expect - even for a phone SoC - that the development boards require
entering some kind of Faustian contract for development of low-level
software. What if
someone wants to develop a platform that doesn't require signing?

That said most of these dev boards have completely mangled JTAG anyway, and
I know Inforce (and Hardkernel, and so on) love their barely-ever-updated custom
firmware binaries, so..

The best thing would be to pick up one of those boards and port a PSCI firmware
to it (ATF or your own..) and just embarrass the SoC vendor by having better
mainline power management support (implemented by 10 lines in a device tree)
with the complicated code hidden away behind the scenes there, like it
should have
been done in the first place..

Ta.
Matt Sealey <neko@bakuhatsu.net>
