From: salyzyn@android.com (Mark Salyzyn)
Date: Mon, 30 Oct 2017 13:34:13 -0700
Subject: [PATCH v3 0/12] arm+arm64: vdso unification to lib/vdso/
In-Reply-To: <20171030141813.nozm5bgumb5qp2ol@lakrids.cambridge.arm.com>
References: <20171027222353.56875-1-salyzyn@android.com>
 <20171030141813.nozm5bgumb5qp2ol@lakrids.cambridge.arm.com>
Message-ID: <6c9aa942-bfc0-4c54-888a-85fd1d43e40c@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/30/2017 07:18 AM, Mark Rutland wrote:
> Hi,
>
> On Fri, Oct 27, 2017 at 03:23:48PM -0700, Mark Salyzyn wrote:
>> Note I noticed a bug in the old implementation of __kernel_clock_getres;
>> it was checking only the lower 32bits of the pointer; this would work
>> for most cases but could fail in a few.
> Sorry if this is a stupid question, but do you mean from a prior version
> of this series, or the one in the kernel today?

apinski at cavium.com noticed this as part of the existing upstream arm64 
assembler when he did the original conversion to C.

Yes, I am aware that a separate patch will need to be made on the 
assembler code for 'stable' trees. And it needs to be addressed 
(separately from this patch series IMHO, but if forced, it would be a 
pre-patch that gets swallowed in patch 10 of the series).

I have not looked into it in depth, because from Android's point of 
view, this patch series (once approved) is going to be back-ported to 
our android-common kernels and will be the solution to the problem. I 
must declare I have to be humble about my understanding of arm64 
assembler, so there is _that_ ...

-- MarkS
