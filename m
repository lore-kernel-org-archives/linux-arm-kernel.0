From: jchandra@broadcom.com (Jayachandran C)
Date: Fri, 22 Apr 2016 16:49:17 +0530
Subject: [PATCH v6 7/7] arm64/perf: Add Broadcom Vulcan PMU support
In-Reply-To: <20160421135450.GO6879@leverpostej>
References: <1461243525-13603-1-git-send-email-ashoks@broadcom.com>
 <1461243525-13603-8-git-send-email-ashoks@broadcom.com>
 <20160421135450.GO6879@leverpostej>
Message-ID: <CAKc_7PXng0zjbfm_w9=p+HKc693Mc50A439v2GRH1j9WC-cvdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 21, 2016 at 7:24 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Thu, Apr 21, 2016 at 05:58:45AM -0700, Ashok Kumar wrote:
>> +static int armv8_vulcan_pmu_init(struct arm_pmu *cpu_pmu)
>> +{
>> +     armv8_pmu_init(cpu_pmu);
>> +     cpu_pmu->name                   = "armv8_brcm_vulcan";
>
> Are we happy with "brcm" being the exposed userspace name? It might be
> better to have this as "armv8_broadcom_vulcan".

Broadcom uses "brcm" as the vendor prefix in device trees, and the
cpu's compatible string is "brcm,vulcan", so this should be ok.

It looks like the A53 and A57 entries have established a convention of
calling the PMU  "armv8_<cpuname>". Otherwise, something very close
to the PMU's OF compatible string would have been better here.

> I'll leave that to you and Will. Either way:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>

If needed:

Acked-by: Jayachandran C <jchandra@broadcom.com>

for the Broadcom Vulcan related changes in the whole series.

JC.
