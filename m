From: edubezval@gmail.com (Eduardo Valentin)
Date: Tue, 29 Nov 2016 22:39:51 -0800
Subject: [PATCH V8 2/6] thermal: bcm2835: add thermal driver for bcm2835
 soc
In-Reply-To: <87lgw2lyu9.fsf@eliezer.anholt.net>
References: <20161117021107.GA2647@localhost.localdomain>
 <766e1b70-d83a-eb52-fa2b-aec435e85673@martin.sperl.org>
 <20161117151019.GA3115@localhost.localdomain>
 <7957B3CC-0E18-4B27-82EB-EF88B7695E28@martin.sperl.org>
 <20161119042224.GA25063@localhost.localdomain>
 <28F93ABE-8210-4389-AE77-4D5E830E669B@martin.sperl.org>
 <20161125052008.GA8342@localhost.localdomain>
 <87twarz6s1.fsf@eliezer.anholt.net>
 <20161129013436.GA3080@localhost.localdomain>
 <87lgw2lyu9.fsf@eliezer.anholt.net>
Message-ID: <20161130063951.GA28700@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Nov 29, 2016 at 02:12:46PM -0800, Eric Anholt wrote:
> Eduardo Valentin <edubezval@gmail.com> writes:
> 
> > Hello Eric, Martin,
> >
> > On Mon, Nov 28, 2016 at 12:30:38PM -0800, Eric Anholt wrote:
> >> Either the device was initialized by the firmware before handing off to
> >> ARM (today's firmware) or it never will be (potential future firmware).
> >
> > And do you have a way to check if the firmware has the initialization
> > code or not? By firmware version, for example. Or even, chip version,
> > maybe?
> 
> We would know if it's not present because the register would be in its
> power-on reset state, which is what the code is checking for.

This just looks odd for a driver, in its probe, to check if device is in
reset state, only then initializes it. if not, it assumes everything is fine.

Besides that, as described in the code, sounds like a quirk.

+        * right now the FW does set up the HW-block, so we are not
+        * touching the configuration registers.
+        * But if the HW is not enabled, then set it up
+        * using "sane" values used by the firmware right now.


And based on what you are describing now, it is not a quirk, but it is by  design (??)

Again, does it hurt to always initialize the device to a *sane* config?

BR,
