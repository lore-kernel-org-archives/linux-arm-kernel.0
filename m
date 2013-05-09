From: holt@sgi.com (Robin Holt)
Date: Thu, 9 May 2013 06:29:41 -0500
Subject: [PATCH -v8 11/11] Move arch/x86 reboot= handling to generic
 kernel.
In-Reply-To: <20130508182304.GP18614@n2100.arm.linux.org.uk>
References: <1367937595-32241-1-git-send-email-holt@sgi.com>
 <1367937595-32241-12-git-send-email-holt@sgi.com>
 <20130508182304.GP18614@n2100.arm.linux.org.uk>
Message-ID: <20130509112941.GV3672@sgi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 08, 2013 at 07:23:05PM +0100, Russell King - ARM Linux wrote:
> On Tue, May 07, 2013 at 09:39:55AM -0500, Robin Holt wrote:
> > +		case 's':
> > +			reboot_mode = REBOOT_WARM;
> > +		case 'h':
> > +			reboot_mode = REBOOT_COLD;
> > +		case 'g':
> > +			reboot_mode = REBOOT_GPIO;
> 
> Further to Ingo's comments, also note that the above is broken.  Any
> of s,h,g will result in REBOOT_GPIO being set which is clearly wrong.

I couldn't be more of an idiot.  I will fix it in -v9.

Robin
