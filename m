From: segher@kernel.crashing.org (Segher Boessenkool)
Date: Tue, 25 Oct 2011 12:29:45 +0200
Subject: [PATCH] of: Add a reg-names property to name reg entries
In-Reply-To: <20111025082632.GJ4429@atomide.com>
References: <1319471697-8970-1-git-send-email-b-cousson@ti.com>
	<20111025082632.GJ4429@atomide.com>
Message-ID: <440786C5-FA1C-4750-9990-0BA5AABC2190@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> +		compatible = "ti,mcasp";
>> +		reg = <0 0x10 0x10>, <0 0x20 0x10>,
>> +		      <1 0x10 0x10>, <1 0x20 0x10>;
>> +		reg-names = "mpu", "dat",
>> +			    "dma", "dma_dat";
>
> Hmm for some systems looks like this can also solve how to pass the
> mux signal names cleanly from DT.

What problem does any of this solve?  The device binding for the
"mcasp" device will have to describe the possible "reg-names", and
what those mean; but the binding already has to describe its "reg"
property anyway.

The example looks like something that should be more properly done
with subdevices, not sure.


Segher
