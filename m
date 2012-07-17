From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 17 Jul 2012 15:52:10 +0100
Subject: linux-next: manual merge of the arm-soc tree with the i2c-embedded
 tree
In-Reply-To: <20120717142222.GE4477@opensource.wolfsonmicro.com>
References: <5003FB7C.4030509@linaro.org>
 <20120717130650.GB27595@sirena.org.uk> <500568D9.10805@linaro.org>
 <20120717133550.GC4477@opensource.wolfsonmicro.com>
 <50057058.2060002@linaro.org>
 <20120717142222.GE4477@opensource.wolfsonmicro.com>
Message-ID: <50057C1A.80606@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/07/12 15:22, Mark Brown wrote:
> On Tue, Jul 17, 2012 at 03:02:00PM +0100, Lee Jones wrote:
>
>> I'm sure sure this is relevant in the current case though, as the
>> i2c properties proposed here are platform specific. What we're
>
> I've not seen the specific example (though fankly it seems quite
> surprising that there's anything other than bus speed that the platform
> might want to configure for I2C...).
>
>> discussing is some consolidation of property names, which I do
>> support in theory. What I fear is that this driver will lack Device
>> Tree functionality for yet another kernel version if it isn't
>> resolved quickly.
>
> Well, if checking the DT checky box is the important thing then just
> adding an of_match_table ought to be enough?  It's fairly common for
> platform data to have lots of stuff that's not used by most systems
> so you can often cover 90% of systems with a very small subset of the
> configurability.

We could do that, but I'd rather do it in full.

I think it would be okay to take the 3 patches due for the v3.6 merge 
window, which target the nmk-i2c driver. If any consolidation happens in 
the mean-time/future I will personally do the work to bring the nmk-i2c 
into line to use any generic bindings which result.

No one else is ever going to use these vendor specific bindings, so I'm 
sure no issues will arise. It also means that we have a fully enabled 
driver which is capable of receiving a new configuration via minor 
changes to the dts, which is important for the current (only) user of 
this driver for an upcoming project.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
