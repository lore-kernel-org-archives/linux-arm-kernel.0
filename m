From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 25 Nov 2014 15:54:52 +0100
Subject: [RFC 0/2] Fix Arndale Octa/Peach Pi boot on Audio subsystem clocks
In-Reply-To: <547497B2.3010907@collabora.co.uk>
References: <1416842312-4405-1-git-send-email-k.kozlowski@samsung.com>
 <54736AD0.4070909@collabora.co.uk> <1416907375.5023.54.camel@AMDC1943>
 <547485F5.50600@collabora.co.uk> <1416925325.26128.6.camel@AMDC1943>
 <547497B2.3010907@collabora.co.uk>
Message-ID: <1416927292.26128.8.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On wto, 2014-11-25 at 15:52 +0100, Javier Martinez Canillas wrote:
> Hello Krzysztof,
> 
> On 11/25/2014 03:22 PM, Krzysztof Kozlowski wrote:
> >> Any ideas?
> > 
> > Yes, I got. On Peach board the i2s0 is enabled in DTS. Probing it could
> > fail because it relies on enabling audss clocks (which cannot be
> > accessed).
> > 
> > I reproduced another hang on Arndale Octa after enabling i2s0 in DTS.
> > Maybe that is the cause also on Peach.
> > 
> 
> You are correct, if I disable i2s0 then I see the logs from
> clk_disable_unused_subtree() and boot hangs when accessing the adma clock:
> 
> clk: checking dout_fimd1
> clk: checking mout_fimd1_final
> clk: checking mout_fimd1
> clk: checking mout_sclk_rpll
> clk: checking fout_rpll
> clk: checking adma
> 
> With i2s0 disabled, your series are indeed enough to make it boot again but
> as you said enabling i2s0 in the DTS makes it hang even with your patches.
> 
> Thanks a lot for digging into this!

My patch only fixed the gate clocks but it didn't touched div and mux.
I'll prepare a v2 of it (I got some feedback) which I hope will fix both
cases: i2s and disabling unused clocks.

Best regards,
Krzysztof
