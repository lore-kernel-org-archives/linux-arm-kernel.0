From: tony@atomide.com (Tony Lindgren)
Date: Fri, 14 May 2010 09:27:39 -0700
Subject: [PATCHv5 0/3] Introduce the /proc/socinfo and use it to export
	OMAP data
In-Reply-To: <20100512152424.803ea807.akpm@linux-foundation.org>
References: <1273587331-24604-1-git-send-email-eduardo.valentin@nokia.com>
	<20100512152424.803ea807.akpm@linux-foundation.org>
Message-ID: <20100514162739.GY3428@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Andrew Morton <akpm@linux-foundation.org> [100512 15:19]:
> 
> I'd have thought that sysfs was an appropriate place for this info. 
> Perhaps under /sys/devices/platform?  Or /sys/devices/system?  Peter's
> original patch didn't tell us where in the hierarchy the file was
> placed, nor why it was placed there, not what its contents look like. 
> But crappy changelogs are the norm :(

To me both proc and sys work, I'm fine either way.
 
> The objections stated in this email:
> http://www.mail-archive.com/linux-omap at vger.kernel.org/msg17630.html
> appear to still apply to this version of the patches?
>
> Kevin didn't explain why he said "Please export these via debugfs". 
> Tony didn't clearly explain why he said "I don't think we want to
> export unique chip identifiers by default".
 
The issue I had was with the unique silicon ID getting exposed
by default to avoid the Pentium id number situation :)

It's now handled with a Kconfig and cmdline option, basically the
same way as the id on x86. So the issues in the email thread
above are sorted out.

Regards,

Tony 
