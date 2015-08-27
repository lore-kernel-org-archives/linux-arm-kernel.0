From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 27 Aug 2015 22:51:22 +0200
Subject: [PATCH 2/2] ARM: dts: rockchip: correct regulator PM properties
In-Reply-To: <CAD=FV=UiCcqCm+W4=ExOps8Npi=mkdVgJ2zgdomOw3YqPhCqug@mail.gmail.com>
References: <1439923455-109818-1-git-send-email-briannorris@chromium.org>
 <10828643.SSUS2EOuvv@phil>
 <CAD=FV=UiCcqCm+W4=ExOps8Npi=mkdVgJ2zgdomOw3YqPhCqug@mail.gmail.com>
Message-ID: <2079050.z559I6SEaj@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 27. August 2015, 12:30:51 schrieb Doug Anderson:
> Hi,
> 
> On Tue, Aug 18, 2015 at 11:19 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> > great, just take into account the deep vs. shallow suspend modes :-)
> 
> One note: do you think it would make sense to re-implement shallow
> suspend as "standby"?  I had a proof of concept doing that in
> <https://chromium-review.googlesource.com/#/c/275123/>.  One nice
> advantage is that you "magically" get a second set of regulator states
> for standby vs "mem".

Somewhere I've read something about keeping wifi associated to an ap during 
suspend which might be a candidate for such a distinction?


> If I understand correctly, the distinction between "standby" and "mem"
> is not too clearly defined, so if we wanted to use it for this it
> wouldn't be terrible?

>From reading Documentation/power/states.txt it looks like the boot-cpu is 
supposed to retain power in the suspend state. Although we also do not lose 
"operating state" in our suspend I guess?

So using the shallow suspend as standby sounds interesting, for the time when 
the deep suspend works too. If there is only one suspend state it 
automatically becomes the "mem"-state it seems.


Heiko
