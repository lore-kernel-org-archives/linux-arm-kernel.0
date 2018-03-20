From: broonie@kernel.org (Mark Brown)
Date: Tue, 20 Mar 2018 09:12:16 +0800
Subject: [PATCH] ASoC: uniphier: evea: add switch for changing source of
 line-in
In-Reply-To: <001101d3bf39$6e3933c0$4aab9b40$@socionext.com>
References: <20180314123900.19505-1-suzuki.katsuhiro@socionext.com>
 <20180314162609.GV2186@sirena.org.uk>
 <001101d3bf39$6e3933c0$4aab9b40$@socionext.com>
Message-ID: <20180320011216.GN2186@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 19, 2018 at 01:19:10PM +0900, Katsuhiro Suzuki wrote:

> > I'll apply for now but this should really be a DAPM control so that we
> > can power down things connected to the disconnected line inputs when
> > recording.

> Thanks a lot for your suggestion. I tried to change the implementation to DAPM
> control as follows:

> I can see the value of ALINSW1 register at 'Line In 1 Mux',0 using
>   amixer get 'Line In 1 Mux',0

> But I can't change the value.
>   amixer set 'Line In 1 Mux',0 LIN2
>   Simple mixer control 'Line In 1 Mux',0
>     Capabilities: enum
>     Items: 'LIN1' 'LIN2' 'LIN3'
>     Item0: 'LIN1'

> Would you tell me what is wrong...

Ugh, I *have* run into that before but I can't remember what triggers it
and your code doesn't have any mistakes I can spot.  Unfortunately I'm
at Linaro Connect this week and don't have a test system I can poke at
with me to remind myself, and I'm still travelling next week
unfortunately.

I'd add some trace to the set code path to make sure everything is being
called as expected.  It's somemthing really small that's hard to make a
warning for in the code IIRC.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180320/0d7b9228/attachment.sig>
