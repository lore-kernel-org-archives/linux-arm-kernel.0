From: myungjoo.ham@samsung.com (=?euc-kr?B?x9S47cHW?=)
Date: Wed, 11 Jul 2012 13:08:15 +0000 (GMT)
Subject: Device tree binding for DVFS table
Message-ID: <20748722.319671342012092123.JavaMail.weblogic@epml17>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hi,
>
> I am working on DT binding for Tegra DVFS.
>
> For Tegra, DVFS node mainly consists of frequency and voltage pairs. 
> Frequency in the pair may change for different process. E.g. for process 
> 1 CPU clock frequency could be 900MHz at 1V while for process 2 it could 
> be 1GHz at 1V.
> Tegra uses vendor specific ids to identify the correct frequency table.

Hello,

It seems that in the example, the values in "voltage-array" and
"frequencies" are switched.

Anyway, what about SoCs that reads information from IEM (or any other module)
 to measure gate delays or some other value to set the appriorate voltage values
 for every possible frequency? I remember some of Exynos SoCs have been doing
 it; dynamically measure the characteristics at boot-up time and apply voltages
 accordingly; they couldn't identify it based on the chip-id or simply by reading
 a single register.


Cheers!
MyungJoo.

> 
> Following is the proposed binding for voltage and frequency tables used 
> in DVFS. Looking for comments/suggestions to make it generic.
