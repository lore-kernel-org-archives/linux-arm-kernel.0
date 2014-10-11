From: johan@kernel.org (Johan Hovold)
Date: Sat, 11 Oct 2014 12:34:32 +0200
Subject: [PATCH 12/12] ARM: dts: am335x-bone-common: enable power off and
 rtc wake up
In-Reply-To: <20141010180941.GZ31348@saruman>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <1412881594-25678-13-git-send-email-johan@kernel.org>
 <20141010180941.GZ31348@saruman>
Message-ID: <20141011103432.GF18988@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 10, 2014 at 01:09:49PM -0500, Felipe Balbi wrote:
> On Thu, Oct 09, 2014 at 09:06:34PM +0200, Johan Hovold wrote:
> > Configure the RTC as system-power controller, which allows the system to
> > be powered off as well as woken up again on subsequent RTC alarms.
> > 
> > Note that the PMIC needs to be put in SLEEP (rather than OFF) mode to
> > maintain RTC power. Specifically, this means that the PMIC
> > ti,pmic-shutdown-controller property must be left unset in order to be
> > able to wake up on RTC alarms.
> > 
> > Tested on BeagleBone Black (rev A5).
> 
> one thing though. IIRC, rtc-only mode does not work with ES1.0 and
> beagle-bone white uses that. Perhaps move this from bone-common to
> boneblack.dts ?

Yeah, I had a quick look at the errata and you seem to be correct. I'll
move it to boneblack.dts.

> other than that
> 
> Reviewed-by: Felipe Balbi <balbi@ti.com>

Thanks,
Johan
