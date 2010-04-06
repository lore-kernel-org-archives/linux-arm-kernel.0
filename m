From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Tue, 06 Apr 2010 18:00:27 +0200
Subject: mx31 snd and mc13783 codec status
In-Reply-To: <20100402104241.GC27613@sirena.org.uk>
References: <4BB22576.1070108@epfl.ch> <20100331083415.GR2241@pengutronix.de>
	<4BB4C362.3000803@epfl.ch> <20100402095358.GZ2241@pengutronix.de>
	<20100402104241.GC27613@sirena.org.uk>
Message-ID: <4BBB5A9B.20004@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> On Fri, Apr 02, 2010 at 11:53:58AM +0200, Sascha Hauer wrote:
>> On Thu, Apr 01, 2010 at 06:01:38PM +0200, Valentin Longchamp wrote:
> 
> What sample rate are you trying to play and what buffer size?  In my
> testing the FIQ was really struggling with most applications at sample
> rates over ~16kHz since you need each audio period to be long enough to
> at least fill the interval between timer polls but applications wanted
> to select buffer sizes that were consumed faster than the timer tick.
> 
> Using an application like speaker-test which has minimal overhead and no
> I/O to worry about helps too.

OK, I have done some tests with speaker-test and I experienced the same 
as you did: with rates over 16kHz, the FIQ starts to have some problems.

> 
>>> If then it looks like on my system, I have a problem with the  
>>> snd_pcm_update_hw_ptr0 call.
> 
>> You could try reverting b4e82b5b785670b68136765059d1afc65c0ae023. Though
>> I have tested it on my boards it may have some implications.
> 
> I was seeing similar behaviour before and after that patch too, the main
> effect there was to improve the error handling when the FIQ and the
> timer get out of sync with each other.

Mark is right, the behavior is similar with or without this patch, it 
does not improve the FIQ problems with rates over 16 kHz.

Val

-- 
Valentin Longchamp, PhD Student, EPFL-STI-LSRO1
valentin.longchamp at epfl.ch, Phone: +41216937827
http://people.epfl.ch/valentin.longchamp
MEB3494, Station 9, CH-1015 Lausanne
