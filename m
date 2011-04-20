From: per.forlin@linaro.org (Per Forlin)
Date: Wed, 20 Apr 2011 09:30:16 +0200
Subject: [PATCH v2 03/12] mmc: mmc_test: add test for none blocking
	transfers
In-Reply-To: <97D3A72708D04647A5AC84A04996E5B5125FB8@039-SN1MPN1-006.039d.mgd.msft.net>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
	<1302116833-24540-4-git-send-email-per.forlin@linaro.org>
	<97D3A72708D04647A5AC84A04996E5B5125FB8@039-SN1MPN1-006.039d.mgd.msft.net>
Message-ID: <BANLkTik126o7w0+97iLL4p51h=0M-26dDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 April 2011 09:09, Lin Tony-B19295 <B19295@freescale.com> wrote:
> Hi Per
>
> ? ? ? ?Just have a glance of your patch, good thinking. But I have a question about this patch. You modified mmc_test to test your driver. Does it mean your driver's performance enhancement depends on application?
I added those tests in mmc_test to compare the performance between
blocking and none blocking. Basically it tests performance gain if
running dma_map and dma_unmap in parallel with the transfer, compared
to running dma_map and dma_unmap in serial with the transfer.

> The caller must have to know the next request so that could make driver prepare next during current transfer?
mmc_test tests the ideal performance gain (all request are linked together).

> So testing your driver with blocking request & non blocking request will have different throughput due to different application mechanism.
Yes.
I added support for mmc non blocking in the mmc block device but the
performance gain here depends on how the FS-requests are propagated
down to the mmc block device. If the request are added one by one,
waiting for the last request to complete before adding the new
request, there will be no performance gain.
To test the mmc block performance I have run IOZone in user space.

> ? ? ? ?Thanks
>
> BR
> Tony
BR
Per
