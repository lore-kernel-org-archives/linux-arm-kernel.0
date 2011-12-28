From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 28 Dec 2011 11:42:37 +0000
Subject: [PATCH V5 4/7] cpufreq: add clk-reg cpufreq driver
In-Reply-To: <20111228033128.GM15863@b20223-02.ap.freescale.net>
References: <1324974262-30963-1-git-send-email-richard.zhao@linaro.org>
 <1324974262-30963-5-git-send-email-richard.zhao@linaro.org>
 <20111228031409.GL15863@b20223-02.ap.freescale.net>
 <20111228033128.GM15863@b20223-02.ap.freescale.net>
Message-ID: <20111228114237.GF24405@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 28, 2011 at 11:31:29AM +0800, Richard Zhao wrote:
> On Wed, Dec 28, 2011 at 11:14:10AM +0800, Richard Zhao wrote:

> > > +		if (cpu_reg) {
> > > +			ret = regulator_is_supported_voltage(cpu_reg,
> > > +					cpu_volts[i * 2], cpu_volts[i * 2 + 1]);

> > Is there any reason you didn't export symbol regulator_is_supported_voltage?
> > and also it don't have !REGULATOR dummy implementation.

> regulator_set_voltage_time and some other functions don't have dummy one
> either.

You can't usefully work with voltages without knowing what the actual
voltages are - the only sensible stubs we could provide would return
errors but then any driver using the stubs would probably fail to do
whatever it was doing.  With enable and disable we can sensibly stub
things out with an always on regulator.
