From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 25 Jan 2017 14:51:24 +0100
Subject: [PATCH 1/2] security: Change name of CONFIG_DEBUG_RODATA
In-Reply-To: <fca01775-9640-8783-a657-a9e6cf0c3e0a@redhat.com>
References: <1484789346-21012-1-git-send-email-labbott@redhat.com>
 <1484789346-21012-2-git-send-email-labbott@redhat.com>
 <20170119075341.GA14530@amd>
 <fca01775-9640-8783-a657-a9e6cf0c3e0a@redhat.com>
Message-ID: <20170125135124.GA20896@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2017-01-25 12:21:05, Laura Abbott wrote:
> On 01/19/2017 08:53 AM, Pavel Machek wrote:
> >On Wed 2017-01-18 17:29:05, Laura Abbott wrote:
> >>
> >>Despite the word 'debug' in CONFIG_DEBUG_RODATA, this kernel option
> >>provides key security features that are to be expected on a modern
> >>system. Change the name to CONFIG_HARDENED_PAGE_MAPPINGS which more
> >>accurately describes what this option is intended to do.
> >
> >I think this is bad change. CONFIG_DEBUG_RODATA is describing what it
> >does, CONFIG_HARDENED_PAGE_MAPPINGS is advertising.
> >
> >We don't do advertising, and we don't force people to re-answer the
> >config questions without good reason.
> >
> >CONFIG_HARDENED_RODATA might fix the first problem, but not the second
> >one.
> >
> >								Pavel
> >								
> 
> (Apologies, my SMTP was set up incorrectly so my response didn't
> actually get sent out)
> 
> CONFIG_DEBUG_RODATA isn't describing what it does though. It misses
> that this config may handle much more than just rodata. I think
> Mark Rutland's suggestion of STRICT_KERNEL_RWX might be more
> descriptive.

CONFIG_BUG=y
CONFIG_LBDAF=y
CONFIG_PM_OPP=y

..it is config option. It is not description of the feature. People
are living with that config option for a while. I'd keep it.

Maybe you can go from CONFIG_DEBUG_RODATA to CONFIG_RODATA... (but
you'll still have people re-answer config option.)


								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170125/14a3cd4f/attachment-0001.sig>
