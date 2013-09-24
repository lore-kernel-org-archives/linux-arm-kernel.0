From: joe@perches.com (Joe Perches)
Date: Tue, 24 Sep 2013 09:24:30 -0700
Subject: [PATCH v5 1/4] media: s5p-tv: Replace mxr_ macro by default dev_
In-Reply-To: <52418B1C.6030600@samsung.com>
References: <1379775649-6331-1-git-send-email-m.krawczuk@partner.samsung.com>
 <1379775649-6331-2-git-send-email-m.krawczuk@partner.samsung.com>
 <52405519.3020504@samsung.com> <13162989.WhfDRzW6dg@amdc1032>
 <1379958282.3575.31.camel@joe-AO722> <52418B1C.6030600@samsung.com>
Message-ID: <1380039870.3575.90.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-09-24 at 14:52 +0200, Tomasz Stanislawski wrote:
> On 09/23/2013 07:44 PM, Joe Perches wrote:
> > On Mon, 2013-09-23 at 17:48 +0200, Bartlomiej Zolnierkiewicz wrote:
> >> On Monday, September 23, 2013 04:50:01 PM Tomasz Stanislawski wrote:
> >>> May I ask what is the rationale for this patch?
> >>> To reduce a few lines of code?
> >> This patch makes source code more generic-like and easier to follow (mxd_r*
> >> macros currently only obfuscate the code and make them harder to read for
> >> everybody, maybe besides the original driver author ;). Removal of few
> >> superfluous lines of code is just a bonus.
> > I don't see any significant issue with this change.
> > Using generic mechanisms is good.
> Hi Joe,

Hi Tomasz

> Sorry for flaming

Sorry, but I didn't feel any heat.
Maybe I'm too far from the fire.
I'll get closer.

>  but please let me explain reasons of my opposition to this patch.

I don't have an issue either way.
I prefer using localized logging macros like mxd_<level>
but I don't much care if actual maintainers want to use
the generic style or a localized style.

> 4. I looked for other files where macro for dev_err is used.
> I tried following shell command on v3.12-rc2.
> 
> git grep -A1 "_err(" | grep -A1 '#define' | grep -B1 "dev_err"
> 
> then processing results using
> grep -v "^--" | cut -d: -f 1 | sort -u | wc

You'll have to look farther then 1 line for dev_err
There are uses like:

#define foo_err(pointer, fmt, ...)			\
do {							\
	if (something)					\
		dev_err(pointer->something, ...);	\
} while (0)

> Currently, due to mentioned reason the patch is not a cleanup-up for me.
> And since I am still a maintainer of this god-forgotten driver I am
> going NACK this patch because it makes my work more difficult and because
> this patch provides only (if any) relative aesthetic gain.

Good for you.
Maintainer preference trumps global style consistency.

cheers, Joe
