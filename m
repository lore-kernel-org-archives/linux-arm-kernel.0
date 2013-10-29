From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Tue, 29 Oct 2013 15:54:27 +0200
Subject: [PATCH 00/19] Enable various Renesas drivers on all ARM platforms
In-Reply-To: <1844190.ApyucSZX8W@avalon>
References: <1383004027-25036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <Pine.LNX.4.64.1310291009121.8404@axis700.grange>
 <1383051980.29619.33.camel@sauron.fi.intel.com> <1844190.ApyucSZX8W@avalon>
Message-ID: <1383054867.29619.34.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-10-29 at 14:22 +0100, Laurent Pinchart wrote:
> > Also, if ARM dependency is ever removed, all these should become 'n' by
> > default in the Kconfig, in order to make sure they do not slip into
> > defconfigs of different architectures.
> 
> The idea is that, if ARM is neither a compile-time nor runtime dependency, it 
> should not be specified in Kconfig. However, if the IP core has never been 
> used on anything but SuperH and ARM, I don't think clobbering the config 
> process with drivers that can't be used on the target architecture would be a 
> really good idea, especially now that we have a COMPILE_TEST Kconfig option. 
> My preference does goes to SUPERH || ARM || COMPILE_TEST over no dependency at 
> all.

Ah, OK, I missed the entire COMPILE_TEST story.

-- 
Best Regards,
Artem Bityutskiy
