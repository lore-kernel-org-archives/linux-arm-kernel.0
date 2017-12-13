From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 13 Dec 2017 17:45:05 +0100
Subject: [PATCH v2 6/7] cpufreq: Add DVFS support for Armada 37xx
In-Reply-To: <20171212072426.GK25177@vireshk-i7> (Viresh Kumar's message of
 "Tue, 12 Dec 2017 12:54:26 +0530")
References: <20171207135616.23670-1-gregory.clement@free-electrons.com>
 <20171207135616.23670-7-gregory.clement@free-electrons.com>
 <20171212072426.GK25177@vireshk-i7>
Message-ID: <87vahapofi.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,
 
 On mar., d?c. 12 2017, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> On 07-12-17, 14:56, Gregory CLEMENT wrote:
>> +/* Power management in North Bridge register set */
>> +#define ARMADA_37XX_NB_L0L1	0x18
>> +#define ARMADA_37XX_NB_L2L3	0x1C
>> +#define	ARMADA_37XX_NB_TBG_DIV_OFF	13
>> +#define	ARMADA_37XX_NB_TBG_DIV_MASK	0x7
>> +#define	 ARMADA_37XX_NB_CLK_SEL_OFF	11
>> +#define	 ARMADA_37XX_NB_CLK_SEL_MASK	0x1
>> +#define	 ARMADA_37XX_NB_CLK_SEL_TBG      0x1
>> +#define	 ARMADA_37XX_NB_TBG_SEL_OFF	9
>> +#define	 ARMADA_37XX_NB_TBG_SEL_MASK	0x3
>> +#define	 ARMADA_37XX_NB_VDD_SEL_OFF	6
>> +#define	 ARMADA_37XX_NB_VDD_SEL_MASK	0x3
>> +#define	 ARMADA_37XX_NB_CONFIG_SHIFT	16
>> +#define ARMADA_37XX_NB_DYN_MOD	0x24
>> +#define	 ARMADA_37XX_NB_CLK_SEL_EN	BIT(26)
>> +#define	 ARMADA_37XX_NB_TBG_EN		BIT(28)
>> +#define	 ARMADA_37XX_NB_DIV_EN		BIT(29)
>> +#define	 ARMADA_37XX_NB_VDD_EN		BIT(30)
>> +#define	 ARMADA_37XX_NB_DFS_EN		BIT(31)
>> +#define ARMADA_37XX_NB_CPU_LOAD	0x30
>> +#define	 ARMADA_37XX_NB_CPU_LOAD_MASK	0x3
>> +#define	 ARMADA_37XX_DVFS_LOAD_0		0
>> +#define	 ARMADA_37XX_DVFS_LOAD_1		1
>> +#define	 ARMADA_37XX_DVFS_LOAD_2		2
>> +#define	 ARMADA_37XX_DVFS_LOAD_3		3
>
> I thought you agreed to using space instead of tab after #define ?

Me too! Actually I did it, and I don't know what happened with this
patch.

However it will be part of the next version and I will double check it.

>
> Looks fine otherwise. You can add below after fixing above tab/space thing:
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>


Thanks,

Gregory

>
> -- 
> viresh

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
