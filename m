From: hramrach@gmail.com (Michal Suchanek)
Date: Fri, 26 Feb 2016 13:51:51 +0100
Subject: [PATCH 1/2] spi: sun4i: add DMA support
In-Reply-To: <20160226122504.GR18327@sirena.org.uk>
References: <1456466217-6793-1-git-send-email-plaes@plaes.org>
 <1456466217-6793-2-git-send-email-plaes@plaes.org>
 <20160226122504.GR18327@sirena.org.uk>
Message-ID: <CAOMqctTz=szSkpk95D_dUJjjpziCKoPv=xRczjfq2Roct-K-OA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 26 February 2016 at 13:25, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Feb 26, 2016 at 07:56:56AM +0200, Priit Laes wrote:
>> From: Emilio L?pez <emilio@elopez.com.ar>
>>
>> This patch adds support for 64 byte or bigger transfers on the
>> sun4i SPI controller. Said transfers will be performed via DMA.
>>
>> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
>> Tested-by: Michal Suchanek <hramrach@gmail.com>
>> Tested-by: Priit Laes <plaes@plaes.org>
>> ---
>
> You *must* sign off any patches you are sending, please see
> SubmittingPatches.

I have sent these patches in the past. Besides this non-technical
objection there were multiple technical objections.

IIRC one was that the driver does not handle the case when the DMA
channels are not available. As I understand it the channels are
exclusively reserved for a particular peripherial on sunxi platform so
this ShoulNotHappen(tm). So it's probably fine for the driver to fail
probe  when you have broken DT or no DMA engine support for sunxi
platform.

The driver could also work fully without DMA and there is a patch for
that also but since nobody will be testing that codepath it's probably
better to not include it.

I have not addressed the other objections so far.

Thanks

Michal
