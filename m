From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Tue, 21 Jan 2014 17:19:23 -0500
Subject: [PATCH 20/73] arm: use subsys_initcall in non-modular pl320 IPC
 code
In-Reply-To: <4922482.oeJaTIvZxl@wuerfel>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
 <1390339396-3479-21-git-send-email-paul.gortmaker@windriver.com>
 <4922482.oeJaTIvZxl@wuerfel>
Message-ID: <52DEF26B.80404@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14-01-21 04:44 PM, Arnd Bergmann wrote:
> On Tuesday 21 January 2014 16:22:23 Paul Gortmaker wrote:
>>
>> Note that direct use of __initcall is discouraged, vs. one
>> of the priority categorized subgroups.  As __initcall gets
>> mapped onto device_initcall, our use of subsys_initcall (which
>> seems to make sense for netfilter code) will thus change this
>> registration from level 6-device to level 4-subsys (i.e. slightly
>> earlier).  However no impact of that small difference is expected.
> 
> This doesn't have anything to do with netfilter. The only user
> of this driver at the moment is the highbank cpufreq driver, but
> that could change.

Thanks -- cut and paste error from an earlier, similar changeset.
Will "s/netfilter/IPC/" 

Paul.
--
> 
> 	Arnd
> 
