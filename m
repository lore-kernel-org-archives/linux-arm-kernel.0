From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 28 Mar 2012 12:42:08 +0100
Subject: [PATCH] ARM: Samsung: Make PM_GENERIC_DOMAINS config depend on
 CONFIG_PM
In-Reply-To: <CAJuYYwRR6eo8LruyOtyi3Sp96jydRvPFhMnbF6wfk55eM-zjbw@mail.gmail.com>
References: <1332843404-25476-1-git-send-email-thomas.ab@samsung.com>
 <20120328105122.GF3232@opensource.wolfsonmicro.com>
 <CAJuYYwQgZqN6nguddjS6bjLhx_ZhUZ5AfcrSAKBa7Ft-Bn6wPQ@mail.gmail.com>
 <20120328113419.GM3232@opensource.wolfsonmicro.com>
 <CAJuYYwRR6eo8LruyOtyi3Sp96jydRvPFhMnbF6wfk55eM-zjbw@mail.gmail.com>
Message-ID: <20120328114208.GP3232@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 28, 2012 at 05:07:03PM +0530, Thomas Abraham wrote:
> On 28 March 2012 17:04, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > Right, this does seem like something which it'd be better to handle
> > more gracefully in the PM core.

> Ok. Selecting PM_GENERIC_DOMAINS without checking for dependency on PM
> did not seem correct.

I dunno, perhaps the PM guys will disagree but it seems like if the
idiomatic way to use this is to select it the API ought to cope with
being selected when half enabled.

As I've said before I'm in favour of just making CONFIG_PM non-optional,
I'm not convinced there's much meaningful use case for disabling it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120328/88fd7cbf/attachment.sig>
