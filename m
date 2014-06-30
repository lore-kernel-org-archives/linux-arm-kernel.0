From: bhelgaas@google.com (Bjorn Helgaas)
Date: Mon, 30 Jun 2014 09:19:58 -0600
Subject: [PATCH 0/2] arm64: clean up /proc/cpuinfo
In-Reply-To: <20140630091352.GP7262@leverpostej>
References: <20140628010440.9839.9366.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20140630091352.GP7262@leverpostej>
Message-ID: <CAErSpo6_igZdHCJuTsxiieZwO2y-jfLr_L3XUqFB7N9aRXgGZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 3:13 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi Bjorn,
>
> On Sat, Jun 28, 2014 at 02:11:58AM +0100, Bjorn Helgaas wrote:
>> On arm64, /proc/cpuinfo currently looks like:
>>
>>     Processor       : AArch64 Processor rev 0 (aarch64)
>>     processor       : 0
>>     processor       : 1
>>     ...
>>     Features        : ...
>>
>> Compared to most other architectures (including arm), this has an extra
>> "Processor" header, and the "Features" and other bits only appear once,
>> so there's no way to have per-CPU features, variants, etc.
>>
>> These patches make arm64 more consistent with the other architectures
>> by removing the extra header and printing the CPU ID information for
>> each CPU.
>
> This looks very much like the series I've been working on [1,2,3], that
> reports the MIDR information and performs some additional sanity
> checking (expecting CPUs to have identical hwcap features).
>
> Did you need this for any reason it particular, or was this just a clean
> up?

I want this because /proc/cpuinfo on arm64 is needlessly different
from other arches, which causes problems for code that parses it.

> Does my series look OK to you?

Yep, yours looks fine to me.  Thanks, I wasn't aware of your previous work.

> Cheers,
> Mark.
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/255389.html
> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/264387.html
> [3] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/266973.html
