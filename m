From: bhe@redhat.com (Baoquan He)
Date: Mon, 11 May 2015 17:41:15 +0800
Subject: [v2 1/5] arm64: kdump: reserve memory for crash dump kernel
In-Reply-To: <5550659D.90006@linaro.org>
References: <1429861989-8417-1-git-send-email-takahiro.akashi@linaro.org>
 <1429861989-8417-2-git-send-email-takahiro.akashi@linaro.org>
 <20150428091935.GJ15033@dhcp-16-116.nay.redhat.com>
 <55505C91.8070503@linaro.org>
 <20150511075447.GA4290@dhcp-128-28.nay.redhat.com>
 <5550659D.90006@linaro.org>
Message-ID: <20150511094115.GB4290@dhcp-128-28.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11/15 at 05:17pm, AKASHI Takahiro wrote:
> On 05/11/2015 04:54 PM, Baoquan He wrote:
> >In this patch you reserve a separate memory region in 1st kernel to
> >store elfcorehdr. I am wondering why you don't call add_buffer in
> >kexec-tools directly. Like this you can get a region from reserved
> >crashkernel region. Then you don't need reserve_elfcorehdr() to reserve
> >memory for elfcorehdr specifically. Like other ARCHs do only one memory
> >region is reserved in 1st kernel, that's crashkernel region.
> 
> I think that you misunderstand somewhat.
> * Kexec-tools only locates/identifies a small region for elfcore header within crash kernel's
> memory region while 1st kernel is running.
> * the data in elfcore header is filled up by kexec_load system call on 1st kernel.
> * 1st kernel doesn't reserve any region for elfcore header because the kernel
> commandline parameters don't contains "elfcorehdr=" parameter, then elfcorehdr_size=0.
> * Crash dump kernel does reserve the region, as I said, because we don't want to
> corrupt the info in elfcore header accidentally while crash kernel is running.
> 
> Clear?

OK, got it now.

Then I am wondering why "elfcorehdr=" can't be contained in kernel
cmdline as other ARCH does. Maybe I need go over all related threads
then know why it is. Thanks for explanation.

Thanks
Baoquan
