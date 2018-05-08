From: robh@kernel.org (Rob Herring)
Date: Tue, 8 May 2018 10:26:59 -0500
Subject: [PATCH] arm: dts: imx: fix IPU OF graph endpoint node names
In-Reply-To: <1525789158.18091.7.camel@pengutronix.de>
References: <20180508135930.5768-1-robh@kernel.org>
 <20180508135930.5768-2-robh@kernel.org>
 <1525789158.18091.7.camel@pengutronix.de>
Message-ID: <CAL_JsqJJ7PZZZX1ks7u4VyQ=6xLMtgd9hPE_7xEP07O=LQ+78g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 8, 2018 at 9:19 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> On Tue, 2018-05-08 at 08:59 -0500, Rob Herring wrote:
>> OF graph endpoint nodes are supposed to be named 'endpoint' with an
>> address if there is more than one. The i.MX IPU binding graph has used
>> unique endpoint names instead which now generate dtc warnings:
>
> This partially reverts commit 416196cd9099 ("ARM: dts: imx6: fix dtc
> warnings for ipu endpoints") and also solves the same issue differently
> by adding reg properties. Should this get a Fixes: tag for these
> changes?

Yes, I'd missed that. This has become my concern with the dtc
warnings. They are often fixed in the wrong way to silence warnings.
This one is trivial, but sometimes they point to deeper issues like
poor binding design. This is certainly true for the new
unique_unit_address check.

Rob
