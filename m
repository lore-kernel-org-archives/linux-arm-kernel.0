From: philippe.retornaz@epfl.ch (=?ISO-8859-1?Q?Philippe_R=E9tornaz?=)
Date: Thu, 03 Oct 2013 18:07:27 +0200
Subject: [PATCH 1/2] ASoC: fsl: imx-ssi: fix probe on imx31
In-Reply-To: <20131003155954.GV27287@sirena.org.uk>
References: <1380630971-11431-1-git-send-email-philippe.retornaz@epfl.ch>
 <1380630971-11431-2-git-send-email-philippe.retornaz@epfl.ch>
 <20131003155954.GV27287@sirena.org.uk>
Message-ID: <524D963F.5080507@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 03/10/2013 17:59, Mark Brown a ?crit :
> On Tue, Oct 01, 2013 at 02:36:10PM +0200, Philippe R?tornaz wrote:
>> On imx31 with mc13783 codec the FIQ is not necessary and not
>> enabled as DMA transfer is available. Change the probe() function
>> to fail only if both FIQ and DMA are not available.
>
> Is this something that used to work but has been broken or is this
> enabling a new feture?  Just wondering if this needs to be sent to
> Linus as a fix.
>

It was working but it is broken since a few release.
There is no need to rush for a fix, both patches can follow the standard
process.
Anyway, there is a pending fix on the imx-sdma driver in order to have the
sound fully working again on my board:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/201498.html

Thanks !

Philippe
