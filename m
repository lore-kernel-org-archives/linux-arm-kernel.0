From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 26 May 2010 19:37:54 +0200
Subject: [PATCH 05/25] msm: generalize clock support.
In-Reply-To: <20100525005115.GA7791@huya.qualcomm.com>
References: <> <1273700754-10256-6-git-send-email-dwalker@codeaurora.org>
	<20100524185540.GA1292@ucw.cz>
	<20100525005115.GA7791@huya.qualcomm.com>
Message-ID: <20100526173753.GD9069@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2010-05-25 00:51:15, David Brown wrote:
> On Mon, May 24, 2010 at 11:55:40AM -0700, Pavel Machek wrote:
> 
> > > + * Redistribution and use in source and binary forms, with or without
> > > + * modification, are permitted provided that the following conditions are
> > > + * met:
> > 
> > Is this even GPL compatible?
> 
> Um, this is a standard 3-clause BSD license.  There are nearly
> 900 existing files in the kernel that have this license on them.

Are you sure? I believe that Dual GPL/BSD is ok, just BSD is not.

pavel at amd:/data/l/linux-good$ less ./include/linux/license.h
#ifndef __LICENSE_H
#define __LICENSE_H

static inline int license_is_gpl_compatible(const char *license)
{
        return (strcmp(license, "GPL") == 0
                || strcmp(license, "GPL v2") == 0
                || strcmp(license, "GPL and additional rights") == 0
                || strcmp(license, "Dual BSD/GPL") == 0
                || strcmp(license, "Dual MIT/GPL") == 0
                || strcmp(license, "Dual MPL/GPL") == 0);
}

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
