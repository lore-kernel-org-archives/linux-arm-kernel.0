From: d.lavnikevich@sam-solutions.net (Dmitry Lavnikevich)
Date: Thu, 11 Sep 2014 15:41:56 +0300
Subject: [alsa-devel] [PATCH 2/5] ASoC: fsl: add imx-tlv320aic3x machine
 driver
In-Reply-To: <20140911064016.GE16489@pengutronix.de>
References: <1410356809-26179-1-git-send-email-d.lavnikevich@sam-solutions.com>
 <1410356809-26179-3-git-send-email-d.lavnikevich@sam-solutions.com>
 <20140910142740.GC16489@pengutronix.de>
 <CAGoOwPSpkNy6uNVAjG2HgiHHscKZjL5wgVrkyGwWCmyU7x+gWg@mail.gmail.com>
 <20140911064016.GE16489@pengutronix.de>
Message-ID: <54119894.8040805@sam-solutions.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 11/09/14 09:40, Markus Pargmann wrote:
> On Wed, Sep 10, 2014 at 11:14:15AM -0700, Nicolin Chen wrote:
>> On Wed, Sep 10, 2014 at 7:27 AM, Markus Pargmann <mpa@pengutronix.de> wrote:
>>> Hi,
>>>
>>> On Wed, Sep 10, 2014 at 04:46:46PM +0300, Dmitry Lavnikevich wrote:
>>>> This is driver for i.MX6 boards with tlv320aic3x audio codecs.
>>>>
>>>> Signed-off-by: Dmitry Lavnikevich <d.lavnikevich@sam-solutions.com>
>>>> ---
>>>>   .../bindings/sound/fsl,imx-audio-tlv320aic3x.txt   |  27 ++++
>>>>   sound/soc/fsl/Kconfig                              |  13 ++
>>>>   sound/soc/fsl/Makefile                             |   2 +
>>>>   sound/soc/fsl/imx-tlv320aic3x.c                    | 177 +++++++++++++++++++++
>>>>   4 files changed, 219 insertions(+)
>>>>   create mode 100644 Documentation/devicetree/bindings/sound/fsl,imx-audio-tlv320aic3x.txt
>>>>   create mode 100644 sound/soc/fsl/imx-tlv320aic3x.c
>>> Is it possible to use the simple-card
>>> (Documentation/devicetree/bindings/sound/simple-card.txt) instead of
>>> adding a new audio card driver? There are also DT bindings for the imx
>>> audiomultiplexer (imx-audmux.txt).
>> I don't know why my mutt doesn't display this mail.
>>
>> Anyway, if Simple Card supports audmux, yes, it's also a good idea.
> Simple Card doesn't support it. But there are DT bindings for the audmux
> device node which allow the definition of a default multiplexer setup.
> That configuration is applied in the probe() function of the audmux driver.
>
> Best regards,
>
> Markus
>

Yes, I've checked - it can be implemented with simple card +
audmux configuration. Thanks for great suggestion. It will be
done in next patchset version.

Best regards,
Lavnikevich Dmitry
