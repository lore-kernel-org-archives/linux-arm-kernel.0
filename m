From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 27 Jun 2012 11:08:14 -0600
Subject: [PATCH V2] ARM: dt: tegra: paz00: add regulators
In-Reply-To: <20120627113100.GF308@opensource.wolfsonmicro.com>
References: <1340757060-27232-1-git-send-email-swarren@wwwdotorg.org>
 <20120627113100.GF308@opensource.wolfsonmicro.com>
Message-ID: <4FEB3DFE.7030203@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2012 05:31 AM, Mark Brown wrote:
> On Tue, Jun 26, 2012 at 06:31:00PM -0600, Stephen Warren wrote:
> 
>> sm1: HW defaults and schematic match at 1.0v. marvin24's kernel had a max
>> of 1.125v, but this wasn't applied since apply_uV wasn't set.
> 
> apply_uV is only valid if a single voltage is specified.  If a voltage
> range were specified and it were acted on we'd take the lowest (not
> highest) voltage allowed.

Ah right. When I apply this, I'll reword that to something more like:

sm1: HW defaults and schematic match at 1.0v. marvin24's kernel had a
max of 1.125v, but this higher voltage was only applied to HW by DVFS
code, which isn't currently supported in mainline.
