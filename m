From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 14 Oct 2012 18:16:39 +0200
Subject: [RFC] Common clock framework for external clock generators
In-Reply-To: <507A9E72.2030800@gmail.com>
References: <4FAB15DB.5050702@googlemail.com> <5076847A.3010705@gmail.com>
 <5076ED22.3060803@gmail.com> <50785EBF.3060508@gmail.com>
 <507A9AF6.4030008@gmail.com> <507A9E72.2030800@gmail.com>
Message-ID: <507AE567.7040701@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14/2012 01:13 PM, Daniel Mack wrote:
> I think the sub-node style above it nicer because it allows referencing
> the individual clocks outputs with a phandle. We use this chip to
> generate base-frequencies for audio clocks, and so we have to switch
> between two freqs for the multiples of 22.5KHz and 24KHz at runtime.

Both examples allow you to have a phandle for all individual clock-outputs.
The examples weren't complete but with the sub-node style you'll reference
with e.g. <&clkout0> while the flat one will use <&si5351 0>. I still prefer
the flat-style as it will not allow to have a phandle of plls.

Sebastian
