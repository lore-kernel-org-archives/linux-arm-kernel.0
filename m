From: philippe.retornaz@epfl.ch (=?UTF-8?B?UGhpbGlwcGUgUsOpdG9ybmF6?=)
Date: Mon, 07 Oct 2013 11:07:24 +0200
Subject: [alsa-devel] [PATCH 1/2] ASoC: fsl: imx-ssi: fix probe on imx31
In-Reply-To: <CAOMZO5C_kjTJ8iVGc67pcLLaO43arTiyMRQ1822VkBLDm7hzPw@mail.gmail.com>
References: <1380630971-11431-1-git-send-email-philippe.retornaz@epfl.ch>
 <1380630971-11431-2-git-send-email-philippe.retornaz@epfl.ch>
 <20131003155954.GV27287@sirena.org.uk> <524D963F.5080507@epfl.ch>
 <CAOMZO5C_kjTJ8iVGc67pcLLaO43arTiyMRQ1822VkBLDm7hzPw@mail.gmail.com>
Message-ID: <525279CC.8080309@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

Le 04/10/2013 20:10, Fabio Estevam a ?crit :
> On Thu, Oct 3, 2013 at 1:07 PM, Philippe R?tornaz wrote
>> It was working but it is broken since a few release. There is no
>> need to rush for a fix, both patches can follow the standard
>> process.
>
> We have been using  sound/soc/fsl/fsl_ssi.c for the dt imx and
> powerpc parts, and that's probably the reason we haven't noticed this
> bug.

Well, I don't think it's fair to break boards just because they are not
(yet) converted to DT ... this board was merged before the DT era on ARM.

Anyway even on DT it's broken: before the switch to the common asoc pcm
code, the dma API was misused to let it think that the audio part of the
SoC was doing the bus mastering, while in fact the sdma was doing it.

Regards,

Philippe
