From: arno@natisbad.org (Arnaud Ebalard)
Date: Sun, 02 Jun 2013 17:45:58 +0200
Subject: [PATCHv2 1/3] Add support for GMT G762/G763 PWM fan controller
In-Reply-To: <87fvx1pwrl.fsf@natisbad.org> (Arnaud Ebalard's message of "Sat,
 01 Jun 2013 19:26:54 +0200")
References: <cover.1369687670.git.arno@natisbad.org>
 <b44f55c4194f6cd8c94f8a3d63ad5c8bd1d1cfe0.1369687670.git.arno@natisbad.org>
 <20130531221616.GG7626@kw.sim.vm.gnt> <87fvx1pwrl.fsf@natisbad.org>
Message-ID: <87ip1w8qix.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>> I haven't noticed this issue while testing your v1 patch series because
>> at the time I was using a board with an U-Boot modified by LaCie. This
>> last sets the set_cnt register to 0 while U-Boot mainline don't.
>> Actually, the 2Big fan is not configured nor even started by U-Boot
>> mainline. I have to fix this but maybe that something can be done in
>> the g762 Linux driver too ?

At the moment, DT bindings and platform_data structure both allow
setting an initial fan_target value. I could add a 'pwm' binding for DT  
and an assoicated field in platform_data to allow passing an initial
value so that maintainers of platforms with a 2 wire fan (open loop) can
still make the fan somewhat rotate at boot.

This is related but I guess this would not completely solve your issue
though. 

Cheers,

a+
