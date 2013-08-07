From: broonie@kernel.org (Mark Brown)
Date: Wed, 7 Aug 2013 17:40:39 +0100
Subject: [PATCH 13/20] ASoC: pxa: pxa-ssp: add DT bindings
In-Reply-To: <1375889649-14638-14-git-send-email-zonque@gmail.com>
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
 <1375889649-14638-14-git-send-email-zonque@gmail.com>
Message-ID: <20130807164039.GM6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 07, 2013 at 05:34:02PM +0200, Daniel Mack wrote:
> This patch contains a cruel hack for looking up the the DMA request
> number. The problem here is that the implementation as it stands will
> allocate the DMA channel from the user of the ssp port, and hence we
> cannot allocate a real channel here.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>  Documentation/devicetree/bindings/sound/mrvl,pxa-ssp.txt |  7 +++++++
>  sound/soc/pxa/pxa-ssp.c                                  | 12 ++++++++++--
>  2 files changed, 17 insertions(+), 2 deletions(-)

So, really this should be part of a generic binding for the SSP device
but obviously this is just a virtual device that binds to a generic bit
of hardware that can be used for other applications like SPI.  For the
ASoC case we could instantiate the DAI from the machine driver but that
isn't going to work for things like SPI.  I'm not 100% sure what the
best way to deal with that is.

One way of doing this is to have two compatible strings for the same bit
of hardware describing the application.  I'm not sure that's nice but it
works...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130807/452862df/attachment.sig>
