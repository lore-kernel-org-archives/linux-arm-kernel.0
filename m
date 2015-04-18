From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 18 Apr 2015 10:04:20 +0100
Subject: [RFC PATCH 1/2] tee: generic TEE subsystem
In-Reply-To: <20150418085712.GB29858@kroah.com>
References: <1429257057-7935-1-git-send-email-jens.wiklander@linaro.org>
 <1429257057-7935-2-git-send-email-jens.wiklander@linaro.org>
 <20150418085712.GB29858@kroah.com>
Message-ID: <20150418090420.GG12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 18, 2015 at 10:57:12AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Apr 17, 2015 at 09:50:56AM +0200, Jens Wiklander wrote:
> > +struct tee_device {
> > +	char name[TEE_MAX_DEV_NAME_LEN];
> > +	const struct tee_desc *desc;
> > +	struct device *dev;
> 
> No, please embed the device in your structure, don't have a pointer to
> it.

Greg, "dev" here is not a locally allocated device, but the parent device.
It's actually the same as struct tee_device.miscdev.parent, which could be
used instead and this member deleted.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
