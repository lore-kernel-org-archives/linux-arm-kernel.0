From: david.wu@rock-chips.com (David.Wu)
Date: Mon, 18 Apr 2016 21:15:46 +0800
Subject: [PATCH v5 2/2] i2c: rk3x: add i2c support for rk3399 soc
In-Reply-To: <20160415175846.GA1533@katana>
References: <1458147438-62387-1-git-send-email-david.wu@rock-chips.com>
 <1458147438-62387-3-git-send-email-david.wu@rock-chips.com>
 <20160414184848.GB2338@katana> <5710DA28.6010104@rock-chips.com>
 <20160415175846.GA1533@katana>
Message-ID: <5714DE02.3040304@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram?

? 2016/4/16 1:58, Wolfram Sang ??:
>> The default frequency rate of function clock is 50M Hz, it can match
>> F/S mode, but HS mode not. If use default rate 50M to get 1.7M
>> scl-frequency rate , we could not get accurately 1.7M frequecy rate.
>> The input-clk-rate is more higher, we get more accurately
>> scl-frequency rate,  as 200M is a suitable input-clk-rate.
>>
>> If 200M was used for F/S mode, it would increase power consumption, so
>> add a option that could be configured from DT.
> If I understand you correctly, couldn't you use clk_set_rate() depending
> on the desired scl frequency which is already described in DT as
> clock-frequency?

Yeap, the default input clock rate is too low for HS mode, and it 's 
flexible that
we get it from DT.
