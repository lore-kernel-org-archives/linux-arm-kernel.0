From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 25 Oct 2018 10:19:54 -0700
Subject: [PATCH 2/2] perf tests: Add a test for the ARM 32-bit [vectors]
 page
In-Reply-To: <20181025021013.GA30116@lunn.ch>
References: <20181025000905.6095-1-f.fainelli@gmail.com>
 <20181025000905.6095-3-f.fainelli@gmail.com> <20181025021013.GA30116@lunn.ch>
Message-ID: <175fd725-a97a-c282-5aa1-952014ff9023@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/18 7:10 PM, Andrew Lunn wrote:
> On Wed, Oct 24, 2018 at 05:09:05PM -0700, Florian Fainelli wrote:
>> perf on ARM requires CONFIG_KUSER_HELPERS to be turned on to allow some
>> independance with respect to the ARM CPU being used. Add a test which
>> tries to locate the [vectors] page, created when CONFIG_KUSER_HELPERS is
>> turned on to help asses the system's health.
> 
> Hi Florian
> 
> I've suffered the pain from missing CONFIG_KUSER_HELPERS. The
> segfaults give little clue as to what is going wrong,and gdb is not
> much use either.

If you have a working backtrace, you can typically see the virtual
address being in 0xffff_xxxx which gives a bit of a clue, but yes, this
is not particularly helpful.

> 
> What i don't see here is any clue to CONFIG_KUSER_HELPERS. If the test
> fails, could you print a message suggesting CONFIG_KUSER_HELPERS on
> ARM?

Sure, sounds reasonable, thanks for taking a look.
-- 
Florian
