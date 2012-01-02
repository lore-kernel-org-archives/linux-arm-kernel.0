From: richard.zhao@linaro.org (Richard Zhao)
Date: Mon, 2 Jan 2012 21:46:01 +0800
Subject: [PATCH 1/1] regulator/fixed: set constraints.apply_uV to 0
In-Reply-To: <20111231215925.GA12740@opensource.wolfsonmicro.com>
References: <1325225213-29655-1-git-send-email-richard.zhao@linaro.org>
 <20111230103026.GA2766@opensource.wolfsonmicro.com>
 <20111230103830.GD2414@b20223-02.ap.freescale.net>
 <20111230104850.GE2766@opensource.wolfsonmicro.com>
 <20111230110842.GE2414@b20223-02.ap.freescale.net>
 <20111231010240.GC5835@opensource.wolfsonmicro.com>
 <20111231012629.GF2414@b20223-02.ap.freescale.net>
 <20111231215925.GA12740@opensource.wolfsonmicro.com>
Message-ID: <CAH8gqwXopRx7_-wSq9djb_np+XeZE0w1HJ1XxZozGOBCF8Z+ZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark
On 1 January 2012 05:59, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Sat, Dec 31, 2011 at 09:26:30AM +0800, Richard Zhao wrote:
>> On Sat, Dec 31, 2011 at 01:02:40AM +0000, Mark Brown wrote:
>
>> > > > It shouldn't actually be passing on the constraint setting the voltage
>> > > > when it constructs the constraints.
>
>> The below code is where fixed regulator construct the constraints.
>
> It's not code which is specific to the fixed regulator, it's generic
> code that's used by all regulators.
The original patch is in fixed regulator driver.
>
>> > > - ? ? ? /* Only one voltage? ?Then make sure it's set. */
>> > > - ? ? ? if (constraints->min_uV == constraints->max_uV)
>> > > - ? ? ? ? ? ? ? constraints->apply_uV = true;
>
>> > No! ?That's going to break *all* other users.
>
>> The above code follows your idea. why you still say no?
>
> You're just randomly inserting code for a specific driver into the
> generic regulator API with no consideration for the effect on other
> users.
>
>> Could you please past some code to show your suggested solution,
>> or you send out a patch to fix it?
>
> Not in the immediate future.
It's a __bug__ blocking others to use fixed regulator with dt binding.

Thanks
Richard
