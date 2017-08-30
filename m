From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 Aug 2017 16:02:49 +0100
Subject: [RESEND PATCH 2/3] regulator: Add support for stm32-vrefbuf
In-Reply-To: <fd883990-cc87-f8cb-ebe7-5c4c4e51d6f6@st.com>
References: <1503925133-30722-1-git-send-email-fabrice.gasnier@st.com>
 <1503925133-30722-3-git-send-email-fabrice.gasnier@st.com>
 <20170829185719.h5fxvzmxbysyxwml@sirena.org.uk>
 <fd883990-cc87-f8cb-ebe7-5c4c4e51d6f6@st.com>
Message-ID: <20170830150249.5sofmjz3n2skzucq@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 30, 2017 at 11:11:24AM +0200, Fabrice Gasnier wrote:
> On 08/29/2017 08:57 PM, Mark Brown wrote:
> > On Mon, Aug 28, 2017 at 02:58:52PM +0200, Fabrice Gasnier wrote:

> >> +static int __init stm32_vrefbuf_init(void)
> >> +{
> >> +	return platform_driver_register(&stm32_vrefbuf_driver);
> >> +}
> >> +subsys_initcall(stm32_vrefbuf_init);

> > Why is this at subsys_initcall()?

> Several consumers depend on it when it's being used, among which: STM32
> internal ADC and DAC, but also external components. Purpose is to ensure
> it's ready before these drivers gets probed, instead of being deferred.
> Is it ok to keep it ?

No, that's not OK - just let deferred probe handle it.  The same thing
applies to all regulator usage.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170830/d47026aa/attachment.sig>
