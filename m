From: broonie@kernel.org (Mark Brown)
Date: Mon, 24 Mar 2014 11:07:51 +0000
Subject: [RFC PATCH] ASoC: wm8904: add CCF support
In-Reply-To: <532FFE7B.2040507@gmail.com>
References: <1395370262-23305-1-git-send-email-voice.shen@atmel.com>
 <20140321103747.GK23372@e106331-lin.cambridge.arm.com>
 <20140321115511.GM11706@sirena.org.uk> <532FFE7B.2040507@gmail.com>
Message-ID: <20140324110751.GH2269@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 24, 2014 at 10:44:27AM +0100, Boris BREZILLON wrote:

> 1) Expose the wm8904 clock tree using the CCF (and its DT bindings)

We can't use the common clock framework in generic drivers since the
common clock framework isn't generally available.

>     clocks {
>         fll {
>             compatible = "wolfson,wm8904-fll"

If we're adding compatible strings for non-reusable subcomponents of a
device like this we're doing something seriously broken.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140324/95eb13e5/attachment.sig>
