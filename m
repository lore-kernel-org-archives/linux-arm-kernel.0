From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 18 Oct 2011 14:30:56 +0200
Subject: [PATCH] amba: be more careful in runtime_suspend/resume
In-Reply-To: <20111018122939.GO21648@n2100.arm.linux.org.uk>
References: <1318940690-30138-1-git-send-email-linus.walleij@stericsson.com>
	<20111018122939.GO21648@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdYmTFV95Bsa3ZqQU1hitJOkcaw8z6hCoPEV3iPW-jhtBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2011 at 2:29 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Oct 18, 2011 at 02:24:50PM +0200, Linus Walleij wrote:
>> From: Linus Walleij <linus.walleij@linaro.org>
>>
>> This checks that a valid pclk actually was retrieved before
>> trying to disable/enable it in the runtime PM hooks on the
>> PrimeCell bus.
>
> This isn't necessary - we only enable runtime-pm after the pclk has been
> obtained and enabled, and disable runtime-pm before we release the pclk.
> So pclk should always be valid here.

Ah of course. Sorry for the fuzz!

Yours,
Linus Walleij
