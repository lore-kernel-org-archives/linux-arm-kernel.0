From: james.hogan@imgtec.com (James Hogan)
Date: Thu, 6 Aug 2015 22:52:05 +0100
Subject: next-20150806 build: 2 failures 52 warnings (next-20150806)
In-Reply-To: <20150806172752.GA20873@sirena.org.uk>
References: <E1ZNIul-0007IF-Ev@optimist> <20150806172752.GA20873@sirena.org.uk>
Message-ID: <20150806215205.GB14493@jhogan-linux.le.imgtec.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Thu, Aug 06, 2015 at 06:27:52PM +0100, Mark Brown wrote:
> On Thu, Aug 06, 2015 at 12:00:47PM +0100, Build bot for Mark Brown wrote:
> 
> Today's linux-next fails to build an ARM allmodconfig with:
> 
> > 	arm-allmodconfig
> > ../lib/test_user_copy.c:67:2: error: implicit declaration of function 'copy_in_user' [-Werror=implicit-function-declaration]
> > ../lib/test_user_copy.c:94:2: error: implicit declaration of function '__copy_in_user' [-Werror=implicit-function-declaration]
> 
> due to 3a646f02c7 (lib/test_user_copy.c: check
> __copy_in_user()/copy_in_user()) which attempts to test copy_in_user()
> which doesn't appear to be defined, at least with the set of include
> files and/or config options you get with an allmodconfig and not at all
> as far as I can tell.

Yeh, the copy_in_user ones need to be conditional upon CONFIG_COMPAT.
Sorry for the breakage. I've asked Andrew to drop them until I can get a
v2 patchset out tomorrow.

Cheers
James
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150806/e8f94a6e/attachment.sig>
