From: viresh.kumar@st.com (viresh kumar)
Date: Wed, 9 Mar 2011 09:13:16 +0530
Subject: [PATCH V6 7/8] ST SPEAr: Remove unused *_SIZE macros from	spear*.h
	files
In-Reply-To: <20110308223210.GA605@n2100.arm.linux.org.uk>
References: <cover.1298977691.git.viresh.kumar@st.com>
	<92b2423158317c4fc283ae07edfe6047fedea5cf.1298977691.git.viresh.kumar@st.com>
	<20110308223210.GA605@n2100.arm.linux.org.uk>
Message-ID: <4D76F754.2020804@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/09/2011 04:02 AM, Russell King - ARM Linux wrote:
> On Tue, Mar 01, 2011 at 04:56:13PM +0530, Viresh Kumar wrote:
>> Now we used standard SZ_* macros instead of self defined *_SIZE macros. This
>> patch removes all such unused *_SIZE macros for spear3xx & 6xx.
> 
> This doesn't appear to apply to spear320.h:
> 
> error: patch failed: arch/arm/mach-spear3xx/include/mach/spear320.h:17
> error: arch/arm/mach-spear3xx/include/mach/spear320.h: patch does not apply
> 

Sorry for that.
I rechecked my branch and found, i had rebased this patchset over your devel branch,
which contained both spear & fixes changes.

This error came due to a fix in spear320.h file, which was:
-#define SPEAR320_SOC_CONFIG_BASE       0xB4000000
+#define SPEAR320_SOC_CONFIG_BASE       0xB3000000

Just a question, Shouldn't i have rebased it on devel only? As these patches may depend
on already committed patches, that are present in spear & fixes branch.

-- 
viresh
