From: jon.medhurst@linaro.org (Jon Medhurst (Tixy))
Date: Sat, 17 Sep 2011 15:34:42 +0100
Subject: [ltt-dev] LTTng 2.0 on ARM
In-Reply-To: <20110916162507.GB2100@arm.com>
References: <4E68559A.8080204@linaro.org>
	<BLU0-SMTP86E263003FB9999131E2A196000@phx.gbl>
	<4E6E4250.2000309@linaro.org>
	<BLU0-SMTP6FB53F86865C7F0175B0D96020@phx.gbl>
	<4E6F3B93.5050603@linaro.org>
	<BLU0-SMTP720ADD6D0D065018E5C97196050@phx.gbl>
	<CAH+eYFDrCav6sVzmapfN3YL8omYKc2NHorHuHMXh49dBbzw1Xg@mail.gmail.com>
	<20110914100931.GB2104@arm.com> <1316017628.2576.44.camel@linaro1>
	<20110916162507.GB2100@arm.com>
Message-ID: <1316270082.3681.20.camel@computer2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-09-16 at 17:25 +0100, Dave Martin wrote:
> On Wed, Sep 14, 2011 at 05:27:08PM +0100, Jon Medhurst (Tixy) wrote:
> > This is the same issue I found recently with kprobes [1]. There is also
> > an inconsistency as function symbols in loadable module do have bit zero
> > set, but if the module is built-in then bit zero is clear. 
> 
> Does that mean that some different infrastructure is used to get the module
> symbols compared with kallsyms?

Yes, there's different infrastructure to handle symbols in loadable
modules compared to those in the kernel binary. I mentioned this in [1],
or in your Linaro inbox on 29th Aug ;-)

>   That feels nasty -- they should at least
> be consistent...

I agree, getting them consistent would solve half the problem.

-- 
Tixy


[1] http://www.spinics.net/lists/arm-kernel/msg138283.html
