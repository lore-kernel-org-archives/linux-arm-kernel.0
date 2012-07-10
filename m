From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 10 Jul 2012 18:01:13 +0100
Subject: [PATCH 1/3] ARM: dt: tegra: seaboard: add regulators
In-Reply-To: <4FFC5E1C.7000500@nvidia.com>
References: <4FE8EFC4.3090509@wwwdotorg.org> <4FFC190A.2040800@nvidia.com>
 <20120710134436.GD9409@opensource.wolfsonmicro.com>
 <4FFC31D5.7090600@nvidia.com>
 <20120710135302.GG9409@opensource.wolfsonmicro.com>
 <4FFC4478.7000204@nvidia.com>
 <20120710154201.GE10022@opensource.wolfsonmicro.com>
 <4FFC5ACA.8010003@nvidia.com>
 <20120710165236.GI10022@opensource.wolfsonmicro.com>
 <4FFC5E1C.7000500@nvidia.com>
Message-ID: <20120710170112.GK10022@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2012 at 10:23:48PM +0530, Laxman Dewangan wrote:

> Then I will have 2 question:
> 1. If that pin is connected to battery then what should be entry?
>    vcc1-supply = <>>>;
> Do we need to register battery supply as fixed (non-gpio based) and
> then refer here for phandle?

Use a fixed voltage regulator to represent the battery.

> 2. what about non-dt case? The regulator registration will also fail
> here because of there is no regulator saying vcc1 in this case. Do
> we need to register the vcc1 regualtor as fixed, battery supplied
> regulator in board files so that the ldo's registration will
> success?

Same thing, use a fixed voltage regulator.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120710/428c71d0/attachment.sig>
