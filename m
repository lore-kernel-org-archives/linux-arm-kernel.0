From: pebolle@tiscali.nl (Paul Bolle)
Date: Wed, 27 May 2015 08:55:23 +0200
Subject: [PATCH v4 3/5] dmaengine: pxa: add pxa dmaengine driver
In-Reply-To: <87siaizguz.fsf@belgarion.home>
References: <1432589362-23241-1-git-send-email-robert.jarzmik@free.fr>
 <1432589362-23241-3-git-send-email-robert.jarzmik@free.fr>
 <1432625314.27695.200.camel@x220> <87siaizguz.fsf@belgarion.home>
Message-ID: <1432709723.27695.210.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-05-27 at 08:15 +0200, Robert Jarzmik wrote:
> Paul Bolle <pebolle@tiscali.nl> writes:
> > Was it actually intended for PXA_DMA to be tristate?
> It is designed to be a module, and in the "end" it will be a module.
> 
> What is important to understand is the 3 phases which are going to happen :
>  - phase 1 : state after this is merged
>              pxa_dma must be builtin, for legacy support (see
>              pxad_toggle_reserved_channel()).
>  - phase 2 : slowly, all the pxa drivers are converted to dmaengine
>  - phase 3 : after full conversion, the patch "add support for legacy
>              transition" is reverted.
>              There pxa_dma will become modular, and the tristate will appear.
> 
> In conclusion, it cannot be a module yet, but it will in the future.

Thanks for this explanation. So I didn't miss a comment or some remark
in a commit explanation, did I?


Paul Bolle
