From: edubezval@gmail.com (Eduardo Valentin)
Date: Mon, 28 Nov 2016 17:34:37 -0800
Subject: [PATCH V8 2/6] thermal: bcm2835: add thermal driver for bcm2835
 soc
In-Reply-To: <87twarz6s1.fsf@eliezer.anholt.net>
References: <1478081906-12009-1-git-send-email-kernel@martin.sperl.org>
 <1478081906-12009-3-git-send-email-kernel@martin.sperl.org>
 <20161117021107.GA2647@localhost.localdomain>
 <766e1b70-d83a-eb52-fa2b-aec435e85673@martin.sperl.org>
 <20161117151019.GA3115@localhost.localdomain>
 <7957B3CC-0E18-4B27-82EB-EF88B7695E28@martin.sperl.org>
 <20161119042224.GA25063@localhost.localdomain>
 <28F93ABE-8210-4389-AE77-4D5E830E669B@martin.sperl.org>
 <20161125052008.GA8342@localhost.localdomain>
 <87twarz6s1.fsf@eliezer.anholt.net>
Message-ID: <20161129013436.GA3080@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Eric, Martin,

On Mon, Nov 28, 2016 at 12:30:38PM -0800, Eric Anholt wrote:
> Eduardo Valentin <edubezval@gmail.com> writes:
> 

<cut> 

> The firmware today always initializes thermal.  I suggested adding the
> init code because we (myself and the Pi Foundation) would like to reduce
> how much closed firmware code is required in the platform, and the Linux
> driver doing this would help make that possible in the future.

Oh I see. Backup code for future chips/firmware.

> 
> >> > Who has the ownership of this device?
> >> 
> >> Joined ownership I suppose...
> >> 
> >
> > with no synchronization mechanism?
> 
> Correct, because none is necessary.
> 



<cut>

> 
> Either the device was initialized by the firmware before handing off to
> ARM (today's firmware) or it never will be (potential future firmware).

And do you have a way to check if the firmware has the initialization
code or not? By firmware version, for example. Or even, chip version,
maybe?

If the current firmware will always initialize the chip, I would say,
ARM should simply read the registers, no initialization, unless it is
known that the firmware intentionally left the device uninitialized.

Again, just trying to avoid obscure misbehavior, when running into a
faulty state, and running silently broken.
