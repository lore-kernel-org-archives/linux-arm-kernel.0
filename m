From: balbi@ti.com (Felipe Balbi)
Date: Thu, 17 Jan 2013 12:09:19 +0200
Subject: [[PATCH v2]] OMAP: omap4-panda: add WiLink shared transport
 power functions
In-Reply-To: <20130117100510.GI10814@arwen.pp.htv.fi>
References: <1358372702-13102-1-git-send-email-coelho@ti.com>
 <50F7C4A7.5060202@ti.com> <20130117093417.GH10814@arwen.pp.htv.fi>
 <50F7CA82.4050509@ti.com> <20130117100510.GI10814@arwen.pp.htv.fi>
Message-ID: <20130117100919.GJ10814@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 17, 2013 at 12:05:10PM +0200, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Jan 17, 2013 at 10:55:14AM +0100, Peter Ujfalusi wrote:
> > On 01/17/2013 10:34 AM, Felipe Balbi wrote:
> > >> I just wonder how this is going to work with DT... You are not going to have
> > >> the ability to use callback in this form.
> > >> I think the GPIO handling should be done in the driver itself rather than in
> > >> the board file.
> > > 
> > > that can (should ?) be moved to ti-st eventually. In fact I don't know
> > > why it was removed in the first place, we would need Pavan to help us
> > > with that query.
> > 
> > Yes, this is a good question. I don't know what is the spacial thing platforms
> > need to do in the callback..

hah! looks like I found the reason:

http://git.omapzoom.org/?p=kernel/omap.git;a=blob;f=arch/arm/mach-omap2/board-44xx-54xx-connectivity.c;h=e4852b93e91b6daa8f85cca91a1e7fbcc778f45b;hb=594aedd9e7da0491523411f8999efd98297f4fe4#l177

IMHO:

a) removing gpio handling wasn't necessary, we could just check
	if gpio_is_valid(nshutdown_gpio)

b) that whole omap_serial_ext_uart_enable() looks really hacky. I'm sure
	we can come up with something better.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130117/bb543361/attachment-0001.sig>
