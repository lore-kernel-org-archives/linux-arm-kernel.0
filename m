From: neko@bakuhatsu.net (Matt Sealey)
Date: Thu, 8 Feb 2018 10:52:11 -0600
Subject: [PATCH 1/2] dt-bindings: Documentation for qcom,llcc
In-Reply-To: <1516924513-20183-2-git-send-email-ckadabi@codeaurora.org>
References: <1516924513-20183-1-git-send-email-ckadabi@codeaurora.org>
 <1516924513-20183-2-git-send-email-ckadabi@codeaurora.org>
Message-ID: <CAHCPf3vt-ZCXgTfCZ-LSW3TSXAk5KBz3wCu-LuTOBdCB+sgGgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hiya,

On 25 January 2018 at 17:55, Channagoud Kadabi <ckadabi@codeaurora.org> wrote:
> Documentation for last level cache controller device tree bindings,
> client bindings usage examples.

[snippety snip]

> +- llcc-bank-off:
> +       Usage: required
> +       Value Type: <u32 array>
> +       Definition: Offsets of llcc banks from llcc base address starting from
> +                   LLCC bank0.
> +
> +- llcc-broadcast-off:
> +       Usage: required
> +       Value Type: <u32>
> +       Definition: Offset of broadcast register from LLCC bank0 address.

What's with the redundant namespacing?

Have we not, as a community, realised that we do not need to namespace
properties which are only present under
a single binding or node, or even those that aren't? This mess started
with the regulator bindings and it's never
stopped. What are we at now, 25 years of device trees, 10 years of FDT on Arm?

Notwithstanding the complete waste of rodata in the kernel image for
matching (& increased time to compare), why
wouldn't you consider why "bank-offset" for your node be any different
than a common property for any other node?

And if you need to describe register offsets... why aren't you able to
use the reg property?

Ta,
Matt
