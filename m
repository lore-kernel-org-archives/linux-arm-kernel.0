From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 22 Jun 2016 10:37:42 +0100
Subject: [PATCH 1/2] cpufreq: exynos: use relaxed IO accesors
In-Reply-To: <20160622093552.GD5458@vireshk-i7>
References: <1466587984-14105-1-git-send-email-ben.dooks@codethink.co.uk>
 <20160622093552.GD5458@vireshk-i7>
Message-ID: <2513e267-5bec-1aef-a222-785903f3789d@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/06/16 10:35, Viresh Kumar wrote:
> On 22-06-16, 10:33, Ben Dooks wrote:
>> The use of __raw IO accesors is not endian safe and should be used
>> sparingly. The relaxed variants should be as lightweight and also
>> are endian safe.
> 
> I am not sure if exynos's code is required to be endian safe at all or
> not, but this change wouldn't harm as well.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

It is better for any of the ARMv7 and later to do this. We've been
fixing some of the exynos and other code to be endian safe.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
