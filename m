From: dietmar.eggemann@arm.com (Dietmar Eggemann)
Date: Mon, 8 Feb 2016 13:41:25 +0000
Subject: [PATCH v3 4/6] arm64: Enable dynamic CPU capacity initialization
In-Reply-To: <20160208131320.GA7265@sirena.org.uk>
References: <1454500799-18451-1-git-send-email-juri.lelli@arm.com>
 <1454500799-18451-5-git-send-email-juri.lelli@arm.com> <56B889F7.306@arm.com>
 <20160208131320.GA7265@sirena.org.uk>
Message-ID: <56B89B05.4090207@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/02/16 13:13, Mark Brown wrote:
> On Mon, Feb 08, 2016 at 12:28:39PM +0000, Dietmar Eggemann wrote:
>> On 03/02/16 11:59, Juri Lelli wrote:
> 
>>> +bool arch_wants_init_cpu_capacity(void)
>>> +{
>>> +	return true;
> 
>> Isn't this a little bit too simple? Not every ARM/ARM64 platform is a
>> heterogeneous one.
> 
> Does it matter?  Is there any problem with doing the callibration and
> having it say that all the CPUs performs very similarly?  My
> understanding was that this was simply saying it was worth checking to
> see if there was some asymmetry.
> 

No, the calibration would work on any platform. I can see your point,
you want to have this feature not depend on dt.
