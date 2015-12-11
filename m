From: dv@vollmann.ch (Detlef Vollmann)
Date: Fri, 11 Dec 2015 23:41:37 +0100
Subject: [PATCH 0/5] ARM: orion5x/dove/mv78xx0 multiplatform
In-Reply-To: <20151211145554.GD18249@io.lakedaemon.net>
References: <1448466557-435335-1-git-send-email-arnd@arndb.de>
 <14967875.ttNXUbSTvS@wuerfel> <20151211133601.GB18249@io.lakedaemon.net>
 <3272371.tle8Qz0NMz@wuerfel> <20151211145554.GD18249@io.lakedaemon.net>
Message-ID: <566B5121.5000204@vollmann.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/15 15:55, Jason Cooper wrote:
> On Fri, Dec 11, 2015 at 03:46:53PM +0100, Arnd Bergmann wrote:
>> I think you are right this has come up in the past, but I don't see how
>> it would work in practice without significant changes to driver subsystems:
>>
>> The way we describe devices in DT is often very different from what we
>> have for the traditional board files, and in some cases we don't even
>> support platform data any more, so this would still depend on having
>> properties according to the DT bindings, and require a large chunk of
>> the same code that is doing DT at the moment.
> 
> yes, that's unfortunate.  Perhaps the tinification links are still
> helpful to Detlef.
I've heard of the tinyfication project, but not paid too much attentions.
I believe it's the wrong side around.
For busybox, patches that produce larger binaries without providing
new functionality are just rejected.
Those that provide new functionality and such create bigger binaries
must have a configuration option for still being able to get the
old small binary.

If you accept patches that make the kernel bigger without a configuration
option to avoid this, any tinyfication effort that tries to make the
kernel small again afterwards is IMHO a noble but lost cause.

  Detlef
