From: Anson.Huang@freescale.com (Anson.Huang at freescale.com)
Date: Tue, 17 Dec 2013 13:27:13 +0000
Subject: [PATCH V2 2/2] cpufreq: imx6q: correct VDDSOC/PU voltage
 scaling when cpufreq is changed
In-Reply-To: <20131217132312.GB3185@sirena.org.uk>
References: <1387318102-11070-1-git-send-email-b20788@freescale.com>
 <1387318102-11070-2-git-send-email-b20788@freescale.com>,
 <20131217132312.GB3185@sirena.org.uk>
Message-ID: <4E25F2ED-7CAE-495E-838D-1527184F2159@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Sent from Anson's iPhone

> ? 2013?12?17??21:23?"Mark Brown" <broonie@kernel.org> ???
> 
>> On Tue, Dec 17, 2013 at 05:08:22PM -0500, Anson Huang wrote:
>> 
>>    if (new_freq > old_freq) {
>> +        if (regulator_is_enabled(pu_reg)) {
>> +            ret = regulator_set_voltage_tol(pu_reg, imx6_soc_volt[index], 0);
> 
> As I pointed out while reviewing the regulator driver this is racy,
> nothing stops the regulator state being changed after you read it and if
> you skip setting the voltage then when something comes along and enables
> the regulator later it will be enabled with a possibly incorrect
> voltage.

yes, you are correct, I will remove this PU status check in V3 patch.

Anson
