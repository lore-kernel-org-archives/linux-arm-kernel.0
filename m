From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 9 May 2017 08:39:44 +0200
Subject: [OpenWrt-Devel] [PATCH 2/4] ata: Add DT bindings for the Gemini
 SATA bridge
In-Reply-To: <6e0751d2-8f78-c584-2990-c05bc3090214@gmail.com>
References: <20170506121053.11554-1-linus.walleij@linaro.org>
 <CGME20170506121119epcas5p437ea69e802ba94bd7df83d0bbac1b0bc@epcas5p4.samsung.com>
 <20170506121053.11554-2-linus.walleij@linaro.org>
 <3791456.ZibJefW5cI@amdc3058>
 <CACRpkdYz9Oka0SGJDTr=y4EN-VfggbuKY2s5X43oXg1dgjh1nw@mail.gmail.com>
 <CAKR_QVJTbLMzqsUTEZJOquZ9T5aQ1_=73WAoRWrm+QK9wFhngA@mail.gmail.com>
 <6e0751d2-8f78-c584-2990-c05bc3090214@gmail.com>
Message-ID: <CACRpkdbPJDPs0bMHbKUGXt2E4O=e_rJveKy=hR-_J-GKG7oLkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 9, 2017 at 12:52 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 05/08/2017 02:16 PM, Tom Psyborg wrote:
>> Is it ever going to be added so this endless spam can end?
>
> It's the first iteration of the (S)ATA patchset, and if you are not
> interested, just ignore the thread.

I mailed with Tom and it turns out he thinks openwrt-devel is getting
spammed with these submissions.

It's true in a sense: the patches are targeted for upstream and not
for the openwrt repo.

It's no big deal, I don't want to unnecessarily increase traffic on
openwrt-devel if it is annoying to some.

> Linus is doing everyone a great favor here by making sure that this
> platform gets properly supported upstream such that the cost of
> maintaining in OpenWrt/LEDE/anywhere else comes down to almost zero.

I am porting to D-Link DIR-685 and DNS-313 as part of the
process, so we have two new high-volume routers/NAS boxes
as part of the process. I don't know how to fix the OpenWRT
install and builds for these in the end though.

It is actually probably an even bigger win though.

We have learnt that Faraday Technology is sprinkling silicon blocks
all over any silicon foundries close to Taiwan. Their stuff appear
to be in a lot of cheap routers, NAS etc. They use the number of
successful deployments of the IP block as a selling point. I guess
these guys are commonly called in to consult when kickstarting
silicon design, simply.

It turns out that this and other silicon vendors such as Grain Media,
Andestech, Moschip etc are using the same silicon blocks, so
a bunch of out-of-tree code is actually just duplicate implementations
of Faraday drivers... we already merged Gemini and MoxaArt in
the upstream kernel so we have a common interrupt chip, timer,
PCI driver, and now this IDE/ATA driver (not the FTIDE200 yet though).

So there is maybe not as much unique silicon
in the world as we have come to think, we need to pay attention
to how register maps look on different things.

Yours,
Linus Walleij
