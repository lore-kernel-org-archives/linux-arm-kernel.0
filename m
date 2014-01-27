From: broonie@kernel.org (Mark Brown)
Date: Mon, 27 Jan 2014 20:59:25 +0000
Subject: [PATCH 2/3] ASoC: atmel_wm8904: make it available to choose clock
In-Reply-To: <52D7366B.1030909@atmel.com>
References: <1389669956-2304-1-git-send-email-voice.shen@atmel.com>
 <1389669956-2304-3-git-send-email-voice.shen@atmel.com>
 <20140114203650.GX15567@sirena.org.uk> <52D7366B.1030909@atmel.com>
Message-ID: <20140127205925.GE11841@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 09:31:23AM +0800, Bo Shen wrote:

> >Shouldn't this code be in the DAI driver?  Otherwise this series looks
> >fine to me, though the DT folks might have something to say I guess.

>   For audio on Atmel SoC, it depends on three device nodes, one is
> SSC node, one is the codec node and the sound node.
>   The sound node will parse by machine driver, and machine driver is
> mainly for hardware connection. As the "clk_from_rk_pin" is decided
> by hardware, so, I put it here.
>   If I move the code to dai driver, it will parse the sound node in
> dai driver, I think it will make the code a little bit not explicit.
> What do you think?

I think it should just be a property of the DAI device.  It's true that
the card defines the connections but if something is going to be an
option that's there for most if not all systems then putting it in the
device driver means less effort on each integration.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140127/2940e34c/attachment.sig>
