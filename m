From: broonie@kernel.org (Mark Brown)
Date: Thu, 26 Jun 2014 23:08:23 +0100
Subject: [PATCH 2/2] cpufreq: cpu0: Extend support beyond CPU0
In-Reply-To: <53AB1CC1.4010907@codeaurora.org>
References: <cover.1403684824.git.viresh.kumar@linaro.org>
 <e9c0eef07745e561b9d12dcb50c3e2f7eb3e8880.1403684824.git.viresh.kumar@linaro.org>
 <53AB1CC1.4010907@codeaurora.org>
Message-ID: <20140626220823.GA23300@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 12:02:25PM -0700, Stephen Boyd wrote:

> I don't think this driver should be using regulator_get_optional() (Mark
> B. please correct me if I'm wrong). I doubt a supply is actually
> optional for CPUs, just some DTs aren't specifying them. In those cases,
> the regulator core will insert a dummy supply and the code will work
> without having to check for probe defer and error pointers.

Since the cpufreq driver is actively working with the regulator,
changing voltages and so on it's mostly OK, it's kind of on the border
of something that should do this but there doesn't seem to be a
reasonable way for it to handle not being able to read the voltage
cleanly.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140626/10ec9c81/attachment.sig>
