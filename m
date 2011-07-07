From: saeed.bishara@gmail.com (saeed bishara)
Date: Thu, 7 Jul 2011 13:31:03 +0300
Subject: [PATCH] remove unnecessary cache flush on v6 copypage
In-Reply-To: <CAHkRjk6WNu5h=QCN-8EfyHHG=0MiX4qbcqHiPws=hgXOf2bvMQ@mail.gmail.com>
References: <CAN_5kQDTweB2GLvwgjN+BQuqnhFUp+MOcQr=ZW=8C6XSsC8XtA@mail.gmail.com>
	<CAHkRjk6WNu5h=QCN-8EfyHHG=0MiX4qbcqHiPws=hgXOf2bvMQ@mail.gmail.com>
Message-ID: <CAMAG_eeXPCTeqje9nHTCbehy0dTyc4DqJn7QQyzvGtsDFn7osA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 7, 2011 at 12:02 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Thursday, July 7, 2011, heechul Yun <heechul@illinois.edu> wrote:
>> ARM: mm: remove unnecessary cache flush on v6 copypage
I think you better mention that this is regarding v6 nonaliasing mode.
>>
>> Signed-off-by: Heechul Yun <heechul@illinois.edu>
>
> I would clarify the commit log a bit stating that this flush is no
> longer necessary because of commit c0177800. We had a good reason for
> adding the flush initially.
I agree, but I would also mention that the flush was needed in order
to coherent between dcache and icache, and now this is being handled
by __sync_icache_dcache
saeed
