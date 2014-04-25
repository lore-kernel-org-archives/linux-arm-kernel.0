From: robherring2@gmail.com (Rob Herring)
Date: Fri, 25 Apr 2014 13:19:48 -0500
Subject: [PATCH 0/3] arm64: Default to non-coherent DMA ops
In-Reply-To: <1398447254-18527-1-git-send-email-catalin.marinas@arm.com>
References: <1398447254-18527-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <CAL_JsqLbZDq36kfayBnnXw3UYwu_02WNCS2bqKS8iEzrG_CJeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 25, 2014 at 12:34 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> Following recent discussions and patch from Ritesh, I'm planning to
> align the default DMA ops with 32-bit arm and make them non-coherent. In
> addition, we need to make sure that devices marked explicitly as
> coherent use the correct dma ops. Until Santosh's DMA patches get
> reviewed/merged, the temporary solution is bus notifiers which check the
> "dma-coherent" property and set the right dma ops.

Is this for 3.15? If not, don't you think Santosh's patches will be
ready for 3.16. I need to take another look, but I'm pretty much happy
with them. My only issue really is whether we want to spread the use
of dma-coherent. Will did call my cute little property a hack, but I
have yet to see anything better.

Rob
