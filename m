From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 1 Aug 2012 22:16:44 -0300
Subject: [RFC] ARM: imx6q-sabrelite: Add CLKO IOMUX
In-Reply-To: <CAOMZO5A2g+UCFuiP7yqYkFQ36F=2yrqJA3ssujeYXE_Q0Sz5nQ@mail.gmail.com>
References: <1343833836-14287-1-git-send-email-festevam@gmail.com>
 <CAOMZO5A2g+UCFuiP7yqYkFQ36F=2yrqJA3ssujeYXE_Q0Sz5nQ@mail.gmail.com>
Message-ID: <CAOMZO5AOfc675749bEqrZCxte6FTXm5VWob7hSDNmM3Q4Dj+QA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 1, 2012 at 5:17 PM, Fabio Estevam <festevam@gmail.com> wrote:

> I managed to get a board and tried it with current Linus' tree and
> also linux-next. Both result in:
>
> sgtl5000 0-000a: Device with ID register ffff is not a sgtl5000
> sgtl5000 0-000a: asoc: failed to probe CODEC sgtl5000.0-000a: -19
> asoc: failed to instantiate card imx6q-sabrelite-sgtl5000: -19
> imx-sgtl5000 sound.11: snd_soc_register_card failed (-19)
>
> Any ideas?

Ok, I sent a new patch that fixes this problem.

Also, I learned from Richard Zhao that audio can only be probed
correctly if we power off/on the board. Pressing the reset button
makes the audio probe to fail.
