From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 8 Apr 2016 05:54:45 +0200
Subject: [PATCH 1/2] mfd: max77693: Allow building as a module
In-Reply-To: <20160407132947.GB3323@x1>
References: <1459756459-22061-1-git-send-email-k.kozlowski@samsung.com>
 <20160407132947.GB3323@x1>
Message-ID: <20160408035445.GA9532@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 07, 2016 at 02:29:47PM +0100, Lee Jones wrote:
> On Mon, 04 Apr 2016, Krzysztof Kozlowski wrote:
> 
> > The consumer of max77693 regulators on Trats2 board (samsung-usb2-phy
> > driver) supports deferred probing so the max77693 main MFD driver can be
> > built now as a module. This gives more flexibility and removes manual
> > ordering of init calls.
> > 
> > Suggested-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> > Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > ---
> >  drivers/mfd/Kconfig    |  4 ++--
> >  drivers/mfd/max77693.c | 14 ++------------
> >  2 files changed, 4 insertions(+), 14 deletions(-)
> 
> I assume this can be taken immediately and doesn't depend on anything
> external to the set?
> 
> For my own reference:
>   Acked-by: Lee Jones <lee.jones@linaro.org>

Hi,

Yes, this can be taken as is. Only second patch (changing defconfig)
depends on this. I can take the second patch through samsung tree but
that would require a tag/branch with this... which looks like an
overkill. So maybe you would take both?

Best regards,
Krzysztof
