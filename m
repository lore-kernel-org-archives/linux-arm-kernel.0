From: jrnieder@gmail.com (Jonathan Nieder)
Date: Thu, 6 Sep 2012 00:18:06 -0700
Subject: Dockstar fails to boot since v3.0-rc6-6-g3835d69
In-Reply-To: <1346915288@msgid.manchmal.in-ulm.de>
References: <20120906054034.GA28549@lunn.ch>
 <1346915288@msgid.manchmal.in-ulm.de>
Message-ID: <20120906071806.GA383@mannheim-rule.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Christoph Biedl wrote:

>                                          Comparing .config and playing
> suggests that disabling CONFIG_ARM_PATCH_PHYS_VIRT is a least a
> workaround. Anything more I can test?

Hmm, my previous reaction might have been premature --- this might
be [1] after all.  Any idea why 3835d69a6c70 affected anything?  If
you take a .config that reproduced this and try

	git checkout 3835d69a6c70^
	make deb-pkg

does that give you a non-broken kernel?

Do you use uBoot, and if so, what version?  If not, what bootloader?

Thanks,
Jonathan

[1] https://bugzilla.kernel.org/show_bug.cgi?id=42680
