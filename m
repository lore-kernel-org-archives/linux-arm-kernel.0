From: nandor.han@ge.com (Han, Nandor (GE Healthcare))
Date: Mon, 12 Dec 2016 15:48:02 +0200
Subject: EXT: imx-sdma UART series failed for i.MX51
In-Reply-To: <1481538186.727700380@f399.i.mail.ru>
References: <1481538186.727700380@f399.i.mail.ru>
Message-ID: <4f8cf2ee-3cd6-31ce-dc12-8a763f19f8e5@ge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander,
    Thanks for info. I have already posted a patch that probably will 
fix this issue.

https://lkml.org/lkml/2016/10/11/319

It was already tested on imx6 and imx53. Let me know how it works.

Reference:
http://lists-archives.com/linux-kernel/28679793-ext-pre-4-9-rc-dma-regression-imx6-sound-etc.html


On 12/12/2016 12:23, Alexander Shiyan wrote:
> Hello all.
>
> Upgrading the kernel from version 4.7 (to latest) has resulted in inoperable for i.MX51 DMA.
> It appears on sound playback (fsl_ssi with DMA). The sound is intermittent and a feeling that
> the each sound channel eats a part of buffer from another channel.
> Git-bisect found a first bad commit "first bad commit: [5881826ded79cf3c3314ee2d84c3bfa94e111b42]
> dmaengine: imx-sdma - update the residue calculation for cyclic channels" and after revert this commit,
> the problem has gone.
>
> Additionally, I had to disable DMA for the UART, because the revert the patch above led to the
> inoperability of the UART receiving part, although even before the series of all UART-SDMA
> patches still functioned normally (with imx6q check commented out).
>
> Any ideas?
>
> Thanks.
>
> shc at shc /home/ARM/linux $ git bisect log
> git bisect start
> # good: [c8d2bc9bc39ebea8437fd974fdbc21847bb897a3] Linux 4.8
> git bisect good c8d2bc9bc39ebea8437fd974fdbc21847bb897a3
> # bad: [2e972325da7a2984b9045844d4185f4406e7a4b0] Revert "USB debug"
> git bisect bad 2e972325da7a2984b9045844d4185f4406e7a4b0
> # bad: [41844e36206be90cd4d962ea49b0abc3612a99d0] Merge tag 'staging-4.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging

<snip>

-- 
Regards,
     Nandi
