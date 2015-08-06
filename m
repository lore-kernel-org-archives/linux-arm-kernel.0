From: broonie@kernel.org (Mark Brown)
Date: Thu, 6 Aug 2015 18:27:52 +0100
Subject: next-20150806 build: 2 failures 52 warnings (next-20150806)
In-Reply-To: <E1ZNIul-0007IF-Ev@optimist>
References: <E1ZNIul-0007IF-Ev@optimist>
Message-ID: <20150806172752.GA20873@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 06, 2015 at 12:00:47PM +0100, Build bot for Mark Brown wrote:

Today's linux-next fails to build an ARM allmodconfig with:

> 	arm-allmodconfig
> ../lib/test_user_copy.c:67:2: error: implicit declaration of function 'copy_in_user' [-Werror=implicit-function-declaration]
> ../lib/test_user_copy.c:94:2: error: implicit declaration of function '__copy_in_user' [-Werror=implicit-function-declaration]

due to 3a646f02c7 (lib/test_user_copy.c: check
__copy_in_user()/copy_in_user()) which attempts to test copy_in_user()
which doesn't appear to be defined, at least with the set of include
files and/or config options you get with an allmodconfig and not at all
as far as I can tell.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150806/6b5baeb9/attachment.sig>
