From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Wed, 29 Oct 2014 13:36:30 +0800
Subject: [RFC V4 1/3] add CONFIG_HAVE_ARCH_BITREVERSE to support rbit
 instruction
In-Reply-To: <1414560096.10912.18.camel@perches.com>
References: <35FD53F367049845BC99AC72306C23D103E010D18254@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E010D18257@CNBJMBX05.corpusers.net>
 <1414392371.8884.2.camel@perches.com>
 <CAL_JsqJYBoG+nrr7R3UWz1wrZ--Xjw5X31RkpCrTWMJAePBgRg@mail.gmail.com>
 <35FD53F367049845BC99AC72306C23D103E010D1825F@CNBJMBX05.corpusers.net>
 <1414560096.10912.18.camel@perches.com>
Message-ID: <35FD53F367049845BC99AC72306C23D103E010D18263@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Joe Perches [mailto:joe at perches.com]
> > We also change byte_rev_table[] to be static, to make sure no drivers
> > can access it directly.
> 
> You break the build with this patch.
> 
> You can't do this until the users of the table are converted.
> 
> So far, they are not.
> 
> I submitted patches for these uses, but those patches are not yet applied.
> 
> Please make sure the dependencies for your patches are explicitly stated.
> 
Oh,  byte_rev_table[] must be extern,
Otherwise, bitrev8() can't access it ,
I will change it.
