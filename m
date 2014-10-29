From: joe@perches.com (Joe Perches)
Date: Tue, 28 Oct 2014 22:21:36 -0700
Subject: [RFC V4 1/3] add CONFIG_HAVE_ARCH_BITREVERSE to support rbit
 instruction
In-Reply-To: <35FD53F367049845BC99AC72306C23D103E010D1825F@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D103E010D18254@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E010D18257@CNBJMBX05.corpusers.net>
 <1414392371.8884.2.camel@perches.com>
 <CAL_JsqJYBoG+nrr7R3UWz1wrZ--Xjw5X31RkpCrTWMJAePBgRg@mail.gmail.com>
 <35FD53F367049845BC99AC72306C23D103E010D1825F@CNBJMBX05.corpusers.net>
Message-ID: <1414560096.10912.18.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-10-29 at 13:14 +0800, Wang, Yalin wrote:
> this change add CONFIG_HAVE_ARCH_BITREVERSE config option,
> so that we can use arm/arm64 rbit instruction to do bitrev operation
> by hardware.

> We also change byte_rev_table[] to be static,
> to make sure no drivers can access it directly.

You break the build with this patch.

You can't do this until the users of the table
are converted.

So far, they are not.

I submitted patches for these uses, but those patches
are not yet applied.

Please make sure the dependencies for your patches
are explicitly stated.
