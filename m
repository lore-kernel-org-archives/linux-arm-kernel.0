From: olof@lixom.net (Olof Johansson)
Date: Tue, 11 Nov 2014 14:45:09 -0800
Subject: [PATCH] ARM: dts: tegra: move serial aliases to per-board
In-Reply-To: <54627C1F.9050200@wwwdotorg.org>
References: <1415738970-7963-1-git-send-email-olof@lixom.net>
 <54627C1F.9050200@wwwdotorg.org>
Message-ID: <CAOesGMh_8Ft=DKqm=e0fQdREC4aLmAAp3N0QyNsqWn2_rCbmnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[again in plain text mode. Sigh]


On Tue, Nov 11, 2014 at 1:14 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 11/11/2014 01:49 PM, Olof Johansson wrote:
>>
>> There are general changes pending to make the /aliases/serial* entries
>> number the serial ports on the system. On tegra, so far the ports have
>> been
>> just numbered dynamically as they are configured so that makes them
>> change.
>>
>> To avoid this, add specific aliases per board to keep the old numbers.
>> This
>> allows us to change the numbering by default on future SoCs while keeping
>> the
>> numbering on existing boards.
>
>
> This change seems mostly OK to me. FWIW though, I had suggested this
> approach when the UART aliases were first added, and Laxman disagreed with
> it. See commit b6551bb933f9 "ARM: tegra: dts: add aliases and DMA requestor
> for serial controller", and its discussion:
> https://lkml.org/lkml/2012/12/25/4. I've CC'd Laxman in case he still
> objects.
>
>> Signed-off-by: Olof Johansson <olof@lixom.net>
>> ---
>>
>> Stephen/Thierry/Alex, as noticed this week we really should try to get
>> this in before the 3.19 merge window so that the global aliases change
>> can happen there without regression.
>
>
> How did we resolve the issue that patch causes with old DTs; namely that it
> causes a change in behaviour for those old DTs? On IRC, I'd wondered whether
> we should set a flag so the kernel ignored aliases for boards containing
> currently upstreamed Tegra SoCs so that issue wouldn't occur. If we did
> that, we wouldn't need this patch.

Another way could be to remove aliases from the kernel side during
booting if they're found. Anyway, feel free to send a patch to do that
if that's your preference.


Thanks,

-Olof
