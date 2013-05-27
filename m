From: dt.tangr@gmail.com (Daniel Tang)
Date: Mon, 27 May 2013 12:23:02 +1000
Subject: [RFC PATCHv4 0/6] arm: Initial TI-Nspire support
In-Reply-To: <201305262323.29519.arnd@arndb.de>
References: <1369480087-24786-1-git-send-email-dt.tangr@gmail.com>
 <201305262323.29519.arnd@arndb.de>
Message-ID: <30BA4666-664F-4DA4-A1D5-C2B8AA63C6AB@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 27/05/2013, at 7:23 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> On Saturday 25 May 2013, Daniel Tang wrote:
>> Changes between v3 and v4:
>> * Remove redundant clock-names in device tree
>> * Re-enable bus access to some peripherals on bootup
>> * Clean up nspire-classic-timer code.
>>  - Implement a nspire_timer_set_mode function
>>  - Removed messy IO_MATCHx and CNTL_MATCHx macros
>>  - Timer starts disabled to begin with
>>  - Interrupt handling code return IRQ_NONE for spurious interrupts
>>  - Delete unnessecary shift
>> * Change clk-nspire to use compatible property to determine IO type
>> * Change device tree bindings to have appropriate vendor prefixes
>> * Added device tree binding documentation
>> * Fix incorrect register addresses for clocks
>> * Use more specific .caps for CLCD
> 
> Looks really good now. I have a few more comments for the first patch,
> mostly for stuff that can be simplified based on stuff we merged in 3.10.
> 
> The one remaining bit that sticks out is the clcd platform data. As I
> said before, I won't require you to convert that to DT in order to
> get your code merged, but I'd also really like to see that happen,
> as we will also need that to get rid of auxdata on the ARM reference
> platforms (integrator, versatile, realview, vexpress).

How would you like me to convert the platform data to DT? AFAIK, the clcd driver isn't aware of DT so the only way is to use the AUXDATA right now.

> 
> Are you motivated to look into those after the base patch gets
> merged into arm-soc?

Of course.

> 
> One comment on the merge path: While we can put any of the patches
> into the arm-soc tree, my preference is definitely for the clk,
> clksource, irqchip and input drivers to go through the respective
> maintainer trees. There are no dependencies to worry about, since
> each patch can compile standalone, and we just need to make sure
> they all get into 3.11 for your platform to work.

Yeah that's totally fine.

> 
> 	Arnd

Cheers,
Daniel Tang
