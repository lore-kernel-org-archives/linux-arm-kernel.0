From: broonie@kernel.org (Mark Brown)
Date: Tue, 9 Jan 2018 16:39:43 +0000
Subject: [PATCH] ASoC: rockchip: i2s: Support mono capture
In-Reply-To: <20180109000115.GA184703@google.com>
References: <20180105221242.22083-1-mka@chromium.org>
 <20180109000115.GA184703@google.com>
Message-ID: <20180109163943.GC11471@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 08, 2018 at 04:01:15PM -0800, Matthias Kaehlcke wrote:

> Due to different issues in our audio recording path I couldn't test
> this properly, and only looked at the .wav data in audacity, which
> appeared to look ok. After putting some of the missing pieces
> together and I noticed that mono capture doesn't work as intended,
> the recorded audio is slowed down. I think this is because the I2S
> controller keeps generating a two-channel stream, however the sound
> system interprets it as a monophonic stream because of the channel
> configuration.

That seems odd - I'd expect underruns somewhere?

> Not sure if there is a clean solution for this if we can't tell the
> hardware to generate a single-channel stream. Any suggestions or do
> we have to revert the patch?

It sounds like a very standard problem with I2S devices, it's a
fundamentally stereo format after all.  If you can't get it to discard
the second channel there's probably not much doing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180109/a50d896d/attachment.sig>
