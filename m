From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Sat, 9 Oct 2010 15:17:59 +0300
Subject: [PATCH] ARM: allow, but warn, when issuing ioremap() on RAM
In-Reply-To: <20101009115551.GA19947@infradead.org>
References: <1286444662-16843-1-git-send-email-felipe.contreras@gmail.com>
	<20101009092127.GB20975@n2100.arm.linux.org.uk>
	<AANLkTimtdV8THgnQL1RxaqLzCUwO27AZSMPi=UtgpML7@mail.gmail.com>
	<201010091311.26335.arnd@arndb.de>
	<AANLkTikdxSQD+9UY70PtCPMgnrovx-dWjrrPJ0AZyG4X@mail.gmail.com>
	<20101009115551.GA19947@infradead.org>
Message-ID: <AANLkTincxhVc86YFevg1nN7KYjgWjWBpb1i4gcq-bB1y@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 9, 2010 at 2:55 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Sat, Oct 09, 2010 at 09:43:50PM +1000, Dave Airlie wrote:
>> I'm guessing some closed source graphics drivers for ARM do all kinds
>> of wrong crap, and Nokia use them a lot, and nobody wants to tell the
>> closed vendors to change their drivers because it costs money.
>
> In which case Russell's message to tell them to sodd off is exactly the
> right thing to do. ?I've never figured out why Felipe cars so much, but
> if he's one of the users of utterly buggy binary drivers that would
> explain his weird actions here.

If you mean PVR SGX, no, I don't use it myself, and it's not a binary
driver, the code is open:
http://meego.gitorious.org/meego-os-base/kernel-source/trees/master/patches

The one I use is tidspbridge which is in staging.

But that's not relevant, what is relevant is that is that the API was
broken without a warning grace period in final releases. "Good"
drivers are broken, I suspect many that haven't made into mainline yet
will receive a bad surprise. Making this only a warning on .36 doesn't
hurt anybody, does it?

-- 
Felipe Contreras
