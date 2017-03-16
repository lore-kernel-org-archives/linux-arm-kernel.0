From: eric@anholt.net (Eric Anholt)
Date: Thu, 16 Mar 2017 11:13:12 -0700
Subject: [PATCH v2 2/3] drm/vc4: Add HDMI audio support
In-Reply-To: <20170227202803.12855-2-eric@anholt.net>
References: <20170227202803.12855-1-eric@anholt.net>
 <20170227202803.12855-2-eric@anholt.net>
Message-ID: <87tw6tyts7.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric Anholt <eric@anholt.net> writes:

> The HDMI encoder IP embeds all needed blocks to output audio, with a
> custom DAI called MAI moving audio between the two parts of the HDMI
> core.  This driver now exposes a sound card to let users stream audio
> to their display.
>
> Using the hdmi-codec driver has been considered here, but MAI meant
> having to significantly rework hdmi-codec, and it would have left
> little shared code with the I2S mode anyway.
>
> The encoder requires that the audio be SPDIF-formatted frames only,
> which alsalib will format-convert for us.
>
> This patch is the combined work of Eric Anholt (initial register setup
> with a separate dmaengine driver and using simple-audio-card) and
> Boris Brezillon (moving it all into HDMI, massive debug to get it
> actually working), and which Eric has the permission to release.
>
> v2: Drop "-audio" from sound card name, since that's already implied
>     (suggestion by Boris)

On IRC, Mark Brown disclaimed responsibility for reviewing this code, so
I've merged it to drm-misc-next.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170316/110e9558/attachment.sig>
