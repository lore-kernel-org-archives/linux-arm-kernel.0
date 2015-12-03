From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 3 Dec 2015 11:35:27 +0530
Subject: [PATCH v5 0/12] cpufreq: Add support for Exynos 5800, 5420, and
 5422
In-Reply-To: <1449091167-20758-1-git-send-email-ben@smart-cactus.org>
References: <1449091167-20758-1-git-send-email-ben@smart-cactus.org>
Message-ID: <20151203060527.GH4302@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

On 02-12-15, 22:19, Ben Gamari wrote:
> 
> This patch series adds cpufreq support for the Exynos 5800, 5420, and 5422
> SOCs. In particular, it adds support for operating-points-v2 bindings to the
> arm-big-little cpufreq driver and updates the above-mentioned SOCs' devicetrees
> to take advantage of this support. There are also a couple of patches improving
> the clarify of the arm-big-little implementation. It is built on a set posted
> by Bartlomiej Zolnierkiewicz in April 2015.
> 
> The most signficant change from the original series is porting to the
> operating-points-v2 devicetree bindings. The series has been tested by me on
> and Odroid XU4 and by Javier Martinez Canillas on a Peach Pit.

Thanks for working with opp-v2 bindings, really appreciate it.

But, before I start reviewing this series, I have few comments.
- We weren't able to use cpufreq-dt driver for big LITTLE platforms
  earlier, as it never had multi cluster support and we wanted
  clock-sharing information via DT.
- That is all fixed now.
- I want Samsung's big LITTLE platforms to use cpufreq-dt and drop
  arm_big_little driver completely.
- The only case for which it (arm_big_little) driver might be useful
  is the IKS solution. Which I don't believe you are going to use in
  future :)

My plan for the arm-big-little driver:
- Migrate all platforms to use cpufreq-dt instead for non-IKS
  solution
- Make arm-big-little driver arm-big-little-iks only driver.

@Sudeep: What would it take you to use cpufreq-dt for ARM's platforms
?

-- 
viresh
